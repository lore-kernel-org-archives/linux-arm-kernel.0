From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Jan 2016 21:30:59 +0100
Subject: [linux-sunxi] [RFC PATCH] drivers: pinctrl: add driver for
 Allwinner A64 SoC
In-Reply-To: <568A4972.8030602@arm.com>
References: <1451582246-32373-1-git-send-email-andre.przywara@arm.com>
 <CAEzqOZsE_kDChAbLkwmwjqdDbovv1e0G1tTffhhp25PkwJQ0+Q@mail.gmail.com>
 <568A4972.8030602@arm.com>
Message-ID: <20160104203059.GG11722@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Mon, Jan 04, 2016 at 10:29:06AM +0000, Andre Przywara wrote:
> >> diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
> >> index e080290..130e7bc 100644
> >> --- a/drivers/pinctrl/sunxi/Makefile
> >> +++ b/drivers/pinctrl/sunxi/Makefile
> >> @@ -12,5 +12,6 @@ obj-$(CONFIG_PINCTRL_SUN7I_A20)               += pinctrl-sun7i-a20.o
> >>  obj-$(CONFIG_PINCTRL_SUN8I_A23)                += pinctrl-sun8i-a23.o
> >>  obj-$(CONFIG_PINCTRL_SUN8I_A23_R)      += pinctrl-sun8i-a23-r.o
> >>  obj-$(CONFIG_PINCTRL_SUN8I_A33)                += pinctrl-sun8i-a33.o
> >> +obj-$(CONFIG_PINCTRL_A64)              += pinctrl-a64.o
> > 
> > Shouldn't this follow pinctrl config name like other sunXi SOCs?
> > This should be PINCTRL_SUN??_A64.
> 
> I never really got the reason we use those sunxi names in addition to
> the SoC name in the first place, maybe apart from copying from some
> Allwinner code.
> Since I decided to not look at Allwinner's BSP at all (if avoidable), I
> also thought it would be time to drop that sunxi naming, which looks
> redundant to me.
> Is there any reason why we would need this (beside having a rather
> unique identifier prefix)?

It's mostly historical.


Back when we started this, There was a few SoCs already out: A10,
A10s, A12 and A13, which was very similar to the Cortex-A naming
scheme (and I think the Cortex-A12 was also announced at the time).

We couldn't really use the SoC family either, since there was already
multiple SoCs that were part of the same family (the A10s, A12 and
A13, part of the sun5i family).

In order to avoid any confusion, we chose to go with both to uniquely
and without any confusion possible, and we just went on with that
naming scheme for consistency.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/3d09d643/attachment.sig>
