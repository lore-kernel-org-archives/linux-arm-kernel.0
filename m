From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Jan 2015 09:16:07 +0100
Subject: [PATCH v4 2/9] clk: sunxi: Add driver for A80 MMC config
 clocks/resets
In-Reply-To: <CAGb2v64fpt-iw7Yf5OjTeZSJUb4z48jMd5T5nvM1vCzf=xEF3Q@mail.gmail.com>
References: <1421471974-32719-1-git-send-email-wens@csie.org>
 <1421471974-32719-3-git-send-email-wens@csie.org>
 <20150119215734.GL4367@lukather>
 <CAGb2v64fpt-iw7Yf5OjTeZSJUb4z48jMd5T5nvM1vCzf=xEF3Q@mail.gmail.com>
Message-ID: <20150120081607.GT4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 10:13:05AM +0800, Chen-Yu Tsai wrote:
> >> +     clk_parent = of_clk_get_parent_name(np, 0);
> >> +     if (!clk_parent)
> >> +             return -EINVAL;
> >> +
> >> +     data->clk = devm_clk_get(&pdev->dev, NULL);
> >> +     if (IS_ERR(data->clk)) {
> >> +             dev_err(&pdev->dev, "Could not get clock\n");
> >> +             return PTR_ERR(data->clk);
> >> +     }
> >
> > I'm wondering, why are you using of_clk_get_parent_name here, instead
> > of __clk_get_name on data->clk? That would avoid parsing the DT while
> > we already have that info.
> 
> I hadn't thought of that. I was sticking to public consumer APIs.
> Do you want me to respin this one?

I don't think it's really a !consumer API. All it does is returning
clk->name, which is accessible even to consumers.

But yeah, please resend it.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150120/07529805/attachment.sig>
