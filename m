From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 27 Dec 2012 19:31:24 +0000
Subject: [PATCH 4/4 v2] net/smsc911x: Provide common clock functionality
In-Reply-To: <CACRpkdZGC=f0X1wLt1QLMB=x+ba6VRDAbRcW6wR_2gvNLuGw1g@mail.gmail.com>
References: <1355937587-31730-1-git-send-email-lee.jones@linaro.org>
 <1355937587-31730-4-git-send-email-lee.jones@linaro.org>
 <CACRpkda79O_b3Z8g7Sy7vMtW9neZU4x-Z=iEQgjqu4X5tFKyhw@mail.gmail.com>
 <20121220192441.GC14363@n2100.arm.linux.org.uk>
 <20121220203514.GN2691@gmail.com>
 <20121220205113.GD14363@n2100.arm.linux.org.uk>
 <20121221091306.GO2691@gmail.com>
 <20121221092421.GG14363@n2100.arm.linux.org.uk>
 <20121221114105.GP2691@gmail.com>
 <CACRpkdZGC=f0X1wLt1QLMB=x+ba6VRDAbRcW6wR_2gvNLuGw1g@mail.gmail.com>
Message-ID: <CAF2Aj3jjTYRQ6sOHfQwZOtZ-HwLn2Rkt8oCZpT-TiS4gy7-Ojg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No, you're right, I'm a moron.

Will fix up and resend when I'm back to work.

Sent from my mobile Linux device.
On Dec 26, 2012 12:51 AM, "Linus Walleij" <linus.walleij@linaro.org> wrote:

> On Fri, Dec 21, 2012 at 12:41 PM, Lee Jones <lee.jones@linaro.org> wrote:
>
> > +       if (IS_ERR(pdata->clk)) {
> > +               ret = clk_prepare_enable(pdata->clk);
> > +               if (ret < 0)
> > +                       netdev_err(ndev, "failed to enable clock %d\n",
> ret);
> > +       }
>
> I think you got all of these backwards now, shouldn't it be if
> (!IS_ERR(pdata->clk)) { } ...?
>
> It's late here but enlighten me if I don't get it.
>
> > +       if (IS_ERR(pdata->clk))
> > +               clk_disable_unprepare(pdata->clk);
>
> Dito.
>
> > +       /* Request clock */
> > +       pdata->clk = clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR(pdata->clk))
> > +               netdev_warn(ndev, "couldn't get clock %li\n",
> PTR_ERR(pdata->clk));
>
> This one seems correct though.
>
> > +       /* Free clock */
> > +       if (IS_ERR(pdata->clk)) {
> > +               clk_put(pdata->clk);
> > +               pdata->clk = NULL;
> > +       }
>
> Should be !IS_ERR()
>
> Yours,
> Linus Walleij
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121227/73803030/attachment-0001.html>
