From: sourav.poddar@ti.com (Poddar, Sourav)
Date: Wed, 9 Feb 2011 11:38:56 +0530
Subject: [PATCH 0/5] Change omap DEBUG_LL code to use inituart for
	AUTO_ZRELADDR and ARM_PATCH_PHYS_VIRT
In-Reply-To: <20110204012317.26410.55157.stgit@baageli.muru.com>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
Message-ID: <AANLkTik_22C6Uq1tLHowq0drf6h82XbeXF2ggzoaQbqU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 4, 2011 at 6:56 AM, Tony Lindgren <tony@atomide.com> wrote:
> Here are the changes to make omap DEBUG_LL code generic using
> the new inituart macro posted in a separate series. This allows
> leaving out the dependency to the uncompress code and allows
> error messages when trying to boot a wrong zImage.
>
> Adding support for new machines should be only additional two
> lines of assembly per machine after these patches.
>
> Regards,
>
> Tony
>
> ---
>
> Tony Lindgren (5):
> ? ? ?omap: Remove code configuring the DEBUG_LL serial port using uncompress code
> ? ? ?omap: Use inituart to configure the debug serial port based on machine ID
> ? ? ?omap: Add support for CONFIG_AUTO_ZRELADDR for DEBUG_LL
> ? ? ?omap: Combine debug-macro.S for omap1 and omap2+
> ? ? ?omap: Add CONFIG_AUTO_ZRELADDR and CONFIG_ARM_PATCH_PHYS_VIRT to defconfigs
>
>
> ?arch/arm/configs/omap1_defconfig ? ? ? ? ? ? ? | ? ?2
> ?arch/arm/configs/omap2plus_defconfig ? ? ? ? ? | ? ?2
> ?arch/arm/mach-omap1/include/mach/debug-macro.S | ? 98 ---------
> ?arch/arm/mach-omap1/serial.c ? ? ? ? ? ? ? ? ? | ? ?7 +
> ?arch/arm/mach-omap2/include/mach/debug-macro.S | ?138 -------------
> ?arch/arm/mach-omap2/serial.c ? ? ? ? ? ? ? ? ? | ? ?7 +
> ?arch/arm/plat-omap/include/plat/debug-macro.S ?| ?257 ++++++++++++++++++++++++
> ?arch/arm/plat-omap/include/plat/serial.h ? ? ? | ? 34 ---
> ?arch/arm/plat-omap/include/plat/uncompress.h ? | ? 32 +--
> ?9 files changed, 284 insertions(+), 293 deletions(-)
> ?create mode 100644 arch/arm/plat-omap/include/plat/debug-macro.

Boot tested linux-next branch with omap2plus_defconfig using NFS filesystem
along with the above 5 patch series and
2 patch series (Allow using machine ID for DEBUG_LL macros)
on Omap 2420,2430,3430 SDPs and Omap4 blaze.

Tested-by: Sourav Poddar<sourav.poddar@ti.com>
