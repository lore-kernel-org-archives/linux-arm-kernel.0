From: nm@ti.com (Nishanth Menon)
Date: Fri, 13 Feb 2015 10:01:29 -0600
Subject: [PATCH 0/9] ARM: DRA7: add display support
In-Reply-To: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <54DE1FD9.6030801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2015 09:11 AM, Tomi Valkeinen wrote:
> Hi,
> 
> This series adds the arch/arm/ side of the display support for DRA7 (DRA72x,
> DRA74x, AM54xx) SoCs. Also support for HDMI output on x15 and DRA72 EVM boards
> is added.
> 
> The series is based on OMAPDSS driver patches in fbdev changes for 3.20, which
> have been merged to Linus' tree.
> 
> The changes are very similar to OMAP5 DSS. All the other patches look fine to
> me except the "RFC: ARM: DRA7: enable DSS_DESHDCP_CLKEN". That's been discussed
> earlier with Paul and Tero, but I don't think we have any good solution for it
> yet.

Is there some specific tag I can test this on (some next perhaps?), I
get the following error:
build fail, Error:
arch/arm/mach-omap2/display.c: In function ?omap_display_get_version?:
arch/arm/mach-omap2/display.c:285:10: error: ?OMAPDSS_VER_DRA7xx?
undeclared (first use in this function)
arch/arm/mach-omap2/display.c:285:10: note: each undeclared identifier
is reported only once for each function it appears in
arch/arm/mach-omap2/display.c:288:1: warning: control reaches end of
non-void function [-Wreturn-type]
make[1]: *** [arch/arm/mach-omap2/display.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2
make: *** Waiting for unfinished jobs....


Further are you proposing this for 3.20 or 3.21 window? 3.20, we seem
to have already missed.


> 
>  Tomi
> 
> Tomi Valkeinen (9):
>   arm/dts: dra7xx: add 'ti,set-rate-parent' for dss_dss_clk
^^
>   ARM: DRA7: hwmod: add DMM hwmod description
>   ARM: DRA7: hwmod: set DSS submodule parent hwmods
>   ARM: OMAP: display: change compat names to array
>   ARM: OMAP2+: display: detect DRA7 DSS
>   arm/dts: dra7.dtsi: add DSS support
^^
>   arm/dts: dra72-evm.dts: add HDMI
^^
>   arm/dts: am57xx-beagle-x15.dts: add HDMI

ARM: dts: am57xx-beagle-x15: Add HDMI

Would be good to follow above convention for all dts patches $subject.


>   RFC: ARM: DRA7: enable DSS_DESHDCP_CLKEN
> 
>  arch/arm/boot/dts/am57xx-beagle-x15.dts   |  80 +++++++++++++++++++++
>  arch/arm/boot/dts/dra7.dtsi               |  38 ++++++++++
>  arch/arm/boot/dts/dra72-evm.dts           | 111 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dra72x.dtsi             |  11 +++
>  arch/arm/boot/dts/dra74x.dtsi             |  15 ++++
>  arch/arm/boot/dts/dra7xx-clocks.dtsi      |   1 +
>  arch/arm/mach-omap2/display.c             |  32 +++++----
>  arch/arm/mach-omap2/io.c                  |  11 +++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  32 +++++++++
>  9 files changed, 316 insertions(+), 15 deletions(-)
> 


-- 
Regards,
Nishanth Menon
