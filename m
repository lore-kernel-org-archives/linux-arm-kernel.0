From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Sep 2017 12:43:28 +0200
Subject: [linux-sunxi] Re: [PATCH 0/3] Simple DVFS support for Allwinner
 A64 SoC
In-Reply-To: <1C624335-37C2-4F22-BE78-A94F26D1D248@aosc.io>
References: <20170923001531.14285-1-icenowy@aosc.io>
 <20170925101027.lghnnll4h6inreqm@flea.home>
 <27EF78BD-6285-4D8D-AA65-8294D797E2FB@aosc.io>
 <20170925102744.qixfwlheeimemhcf@flea.home>
 <1C624335-37C2-4F22-BE78-A94F26D1D248@aosc.io>
Message-ID: <20170925104328.jttvrdbptor5zhsr@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 25, 2017 at 10:29:38AM +0000, Icenowy Zheng wrote:
> 
> 
> ? 2017?9?25? GMT+08:00 ??6:27:44, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
> >On Mon, Sep 25, 2017 at 10:12:09AM +0000, Icenowy Zheng wrote:
> >> ? 2017?9?25? GMT+08:00 ??6:10:27, Maxime Ripard
> ><maxime.ripard@free-electrons.com> ??:
> >> >Hi,
> >> >
> >> >On Sat, Sep 23, 2017 at 12:15:28AM +0000, Icenowy Zheng wrote:
> >> >> This patchset imports simple DVFS support for Allwinner A64 SoC.
> >> >> 
> >> >> As the thermal sensor driver is not yet implemented and some
> >boards
> >> >> have still no AXP PMIC support, now only two OPPs are present --
> >> >> 648MHz at 1.04V and 816MHz at 1.1V to prevent overheat or undervoltage.
> >> >> 
> >> >> PATCH 1 is a fix to the CCU driver of A64, and the remaining
> >patches
> >> >> set up the device tree bits of the DVFS on Pine64.
> >> >
> >> >How has this been tested?
> >> >
> >> >What tasks did you run, with what governor, etc...
> >> 
> >> I only tested manual frequency switching between 648MHz and
> >> 816MHz, and tested the PLL stuck issue by change the OPPs to
> >> some random value.
> >
> >Ideally, we should test that it's actually reliable. Poorly chosen
> >OPPs might lead to corrupt data that you might not get before a while.
> 
> These are OPPs from the official sys_config.fex .

And the rest of the code isn't, such as the clock or regulator code
that is critical as well here.

I'm not asking this out of nowhere, we've had to debug this more than
once already.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170925/c815cfd2/attachment.sig>
