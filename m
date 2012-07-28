From: gautamvivek1987@gmail.com (Vivek Gautam)
Date: Sat, 28 Jul 2012 16:42:02 -0000
Subject: [PATCH 4/8 v2] ARM: EXYNOS5: Add EHCI device from device tree
In-Reply-To: <201207261157.14441.arnd@arndb.de>
References: <1342866729-30460-1-git-send-email-gautam.vivek@samsung.com>
 <1342866729-30460-5-git-send-email-gautam.vivek@samsung.com>
 <201207261157.14441.arnd@arndb.de>
Message-ID: <CAFp+6iFs3ErqoJLzvuDLQ_mS3RABvxa=aw9piVArRKUBPLiztw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 26, 2012 at 8:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Saturday 21 July 2012, Vivek Gautam wrote:
> > @@ -28,6 +29,11 @@ static struct exynos4_ohci_platdata
> smdk5250_ohci_pdata = {
> >         .phy_exit = s5p_usb_phy_exit,
> >  };
> >
> > +static struct s5p_ehci_platdata smdk5250_ehci_pdata = {
> > +       .phy_init = s5p_usb_phy_init,
> > +       .phy_exit = s5p_usb_phy_exit,
> > +};
> > +
> >  /*
> >   * The following lookup table is used to override device names when
> devices
> >   * are registered from device tree. This is temporarily added to enable
>
> I'm a bit confused of the purpose of setting the function pointers here
> when the pointers are always to the same s5p_usb_phy_init/s5p_usb_phy_exit
> identifiers, but you have different definitions of those functions
> depending on which platforms you are building for.
>
> What is the idea here? Are you going to unify the three definitions of
> s5p_usb_phy_init, or is that function going away eventually when we
> get to the point of building exynos/s5p/s3c64xx into the same kernel
> binary?
>
> Should we be differentiating here between the calls at runtime for
different SOCs.
In that case, yes i think we need a way here to have a solution here so
that the function call
goes differently for different soc while in runtime. I will work on this
and get back asap.

>         Arnd
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
Best regards
Vivek
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120728/f79ef87a/attachment.html>
