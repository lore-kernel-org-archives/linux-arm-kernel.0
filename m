From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 04 Jan 2016 13:12:53 +0100
Subject: [RFC PATCH 5/5] arm64: Introduce Allwinner SoC config option
In-Reply-To: <20160104112648.GD11722@lukather>
References: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
 <1450787267-26836-6-git-send-email-andre.przywara@arm.com>
 <20160104112648.GD11722@lukather>
Message-ID: <12966735.VQfHhlD3ne@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 January 2016 12:26:48 Maxime Ripard wrote:
> Hi Andre, Arnd,
> 
> On Tue, Dec 22, 2015 at 12:27:47PM +0000, Andre Przywara wrote:
> > To prepare for supporting the Allwinner A64 SoC, introduce a config
> > option to allow compiling Allwinner (aka. sunxi) specific drivers
> > for ARM64.
> > This patch just defines the ARCH_SUNXI symbol to allow Allwinner
> > specific drivers to be selected during kernel configuration.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> I'm ok taking this patch.
> 
> I'm not quite sure how the process works though with arm64. Should I
> send a PR with this patch to Catalin, or does it go through the usual
> arm-soc maintainers?

We usually take these through arm-soc. 
 
> We should also probably extend the MAINTAINERS entry, shouldn't we?
> 

A lot of the arm64 changes get sent to arm-soc from random developers that
are not in the MAINTAINERS file at the moment, and I'd like to reduce
that, so please pick up whatever arm64 sunxi changes you see that look ok
and send a separate pull request as you do for arm32. Sending patches
separately is fine too, but I'd like to see them come from you to arm at kernel.org
so I don't need to guess whether we should pick them up or not.

This time around, we have two arm64 branches, one for boot/dts and one
combined for Kconfig and defconfig (MAINTAINERS can also go in there). We
are still experimenting with that model though, and it may change in
the future.

	Arnd
