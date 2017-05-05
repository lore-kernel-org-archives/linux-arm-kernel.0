From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 5 May 2017 21:49:01 +0200
Subject: [PATCH v2 03/10] pinctrl: sunxi: add A20 support to A10 driver
In-Reply-To: <52C75207-6F41-4B3F-8953-F4F040358792@aosc.io>
References: <20170504135006.16483-1-icenowy@aosc.io>
 <20170504135006.16483-4-icenowy@aosc.io>
 <20170504140220.26kguf3trz7ocylv@lukather>
 <83062089-19CD-4805-A6DC-2C25D75621FF@aosc.io>
 <20170504144152.34yzk424aqrizmbu@lukather>
 <52C75207-6F41-4B3F-8953-F4F040358792@aosc.io>
Message-ID: <20170505194901.w3el6zucqo6mcoab@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 10:45:11PM +0800, Icenowy Zheng wrote:
> 
> 
> ? 2017?5?4? GMT+08:00 ??10:41:52, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
> >On Thu, May 04, 2017 at 10:03:26PM +0800, Icenowy Zheng wrote:
> >> 
> >> 
> >> ? 2017?5?4? GMT+08:00 ??10:02:20, Maxime Ripard
> ><maxime.ripard@free-electrons.com> ??:
> >> >On Thu, May 04, 2017 at 09:49:59PM +0800, Icenowy Zheng wrote:
> >> >>  static const struct of_device_id sun4i_a10_pinctrl_match[] = {
> >> >> -	{ .compatible = "allwinner,sun4i-a10-pinctrl", },
> >> >> +	{
> >> >> +		.compatible = "allwinner,sun4i-a10-pinctrl",
> >> >> +		.data = (void *)PINCTRL_SUN4I_A10
> >> >> +	},
> >> >> +	{
> >> >> +		.compatible = "allwinner,sun7i-a20-pinctrl",
> >> >> +		.data = (void *)PINCTRL_SUN7I_A20
> >> >> +	},
> >> >>  	{}
> >> >>  };
> >> >
> >> >This means you're going to have two drivers probing for the same
> >> >device: this driver, and the old one. This is not ok, and probably
> >> >introduces some corner cases.
> >> 
> >> The A20 driver is dropped in the next commit.
> >
> >Yes, and that is an issue for bisectability. Anyone that will checkout
> >between those two commits will have a broken kernel, and that is not
> >ok. Any commit should be in a working state.
> 
> Squash them together?

I would simply remove the A20's def_bool in that patch.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170505/0ed3e296/attachment.sig>
