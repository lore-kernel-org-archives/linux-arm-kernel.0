From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 28 Jan 2013 10:34:15 +0000
Subject: OMAP baseline test results for v3.8-rc5
In-Reply-To: <20130126084604.GB8754@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com>
 <20130126084604.GB8754@arwen.pp.htv.fi>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA9456A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 26, 2013 at 14:16:04, Balbi, Felipe wrote:
> On Sat, Jan 26, 2013 at 08:40:07AM +0000, Paul Walmsley wrote:

> > * am335xbone: hangs after "Starting kernel"
> >   - Cause unknown; may be due to CONFIG_EARLY_PRINTK=y?
> >   - http://www.mail-archive.com/linux-omap at vger.kernel.org/msg82297.html
> >   - http://marc.info/?l=linux-omap&m=135903184512238&w=2
> 
> FYI, I don't think it's related to CONFIG_EARLY_PRINTK. Tested with and
> without it, also removed CONFIG_DEBUG_LL completely and nothing seemed
> to help my bone, no matter if I had appended DTB or not.

Following patch with low level debug may help to find where the issue is,
(my observation is that it boots with mainline u-boot)

Regards
Afzal


diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 41b581f..178a411 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -117,6 +117,10 @@ config SOC_AM33XX
        select CPU_V7
        select MULTI_IRQ_HANDLER
        select COMMON_CLK
+       select MACH_AM335XEVM
+
+config MACH_AM335XEVM
+       bool

 config OMAP_PACKAGE_ZAF
        bool
