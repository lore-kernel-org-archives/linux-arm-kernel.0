From: balbi@ti.com (Felipe Balbi)
Date: Tue, 19 Feb 2013 12:56:33 +0200
Subject: [PATCH, RFC 5/8] ARM: OMAP2+: am43: Kconfig
In-Reply-To: <5123537B.8050709@ti.com>
References: <cover.1361186097.git.afzal@ti.com>
 <5951ba90110b97fb494743e1aedf26aaa92b97a9.1361186097.git.afzal@ti.com>
 <5123537B.8050709@ti.com>
Message-ID: <20130219105633.GN23197@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 03:57:07PM +0530, Santosh Shilimkar wrote:
> On Monday 18 February 2013 05:08 PM, Afzal Mohammed wrote:
> >Add Kconfig option for AM43 family of SoC's, these are ARM Cortex A9
> >based (SMP configuration with 1 core).
> >
> >Signed-off-by: Afzal Mohammed <afzal@ti.com>
> >---
> >  arch/arm/mach-omap2/Kconfig | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> >diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> >index 49ac3df..683fbaa 100644
> >--- a/arch/arm/mach-omap2/Kconfig
> >+++ b/arch/arm/mach-omap2/Kconfig
> >@@ -141,6 +141,17 @@ config SOC_AM33XX
> >  	select MULTI_IRQ_HANDLER
> >  	select COMMON_CLK
> >
> >+config SOC_AM43
> >+	bool "TI AM43"
> >+	depends on ARCH_OMAP2PLUS
> >+	default y
> >+	select CPU_V7
> >+	select HAVE_SMP
> You don't need this

actually, this is needed for CONFIG_SMP_ON_UP

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130219/7e99c659/attachment.sig>
