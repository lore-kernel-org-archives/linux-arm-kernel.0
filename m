From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Wed, 6 Feb 2013 04:57:25 +0000
Subject: [PATCH V2 1/6] pinctrl: pinctrl-single: use arch_initcall and
 module_exit
In-Reply-To: <CACRpkdYUBGkRRF_nDbn5tGmtZC_Wucqxz_PjWo0xX_KbnQJ5cw@mail.gmail.com>
References: <1359445134-13323-1-git-send-email-manishv.b@ti.com>
 <1359445134-13323-2-git-send-email-manishv.b@ti.com>
 <CACRpkdbf7TwrjfT2rhqQFGc3yh_Nt117RtzQO2y6g5Ddx5Ay_w@mail.gmail.com>
 <20130201170906.GE22517@atomide.com>	<20130201171124.GF22517@atomide.com>
 <A4887BF146CD57468F700B415D2F47015828C7@DBDE01.ent.ti.com>
 <CACRpkdYUBGkRRF_nDbn5tGmtZC_Wucqxz_PjWo0xX_KbnQJ5cw@mail.gmail.com>
Message-ID: <A4887BF146CD57468F700B415D2F47015831F0@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

On Tue, Feb 05, 2013 at 18:30:48, Linus Walleij wrote:
> On Tue, Feb 5, 2013 at 7:36 AM, Vishwanathrao Badarkhe, Manish <manishv.b@ti.com> wrote:
> 
> > I made following changes, in order to update "dip->p" pointer with 
> > correct value:
> >
> > -       if (!dpi->p) {
> > +       if (IS_ERR_OR_NULL(dpi->p)) {
> >                 dpi->p = devm_pinctrl_get(dev);
> > -               if (IS_ERR_OR_NULL(dpi->p)) {
> > -                       int ret = PTR_ERR(dpi->p);
> > -
> > -                       dev_dbg(dev, "no pinctrl handle\n");
> > -                       /* Only return deferrals */
> > -                       if (ret == -EPROBE_DEFER)
> > -                               return ret;
> > -                       return 0;
> > -               }
> > +               ret = PTR_ERR(dpi->p);
> > +               dev_dbg(dev, "no pinctrl handle\n");
> > +               /* Only return deferrals */
> > +               if (ret == -EPROBE_DEFER)
> > +                       return ret;
> > +               return 0;
> 
> This is based on some old code that I wrote ages ago. Check the pinctrl tree or linux-next for the latest core pin grabbing code.
> Use that instead.

Thanks for your reply.
I have checked with your latest changes regarding pinctrl 
in linux-next tree and these changes are working fine for me.

Regards
Manish Badarkhe
