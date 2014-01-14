From: balbi@ti.com (Felipe Balbi)
Date: Tue, 14 Jan 2014 11:29:01 -0600
Subject: [PATCHv4 7/7] hwspinlock/omap: enable build for AM33xx, AM43xx &
 DRA7xx
In-Reply-To: <52D56B13.2050409@ti.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <1389658764-39199-8-git-send-email-s-anna@ti.com>
 <20140114131207.GB10818@saruman.home> <52D56B13.2050409@ti.com>
Message-ID: <20140114172901.GB27374@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 10:51:31AM -0600, Anna, Suman wrote:
> Felipe,
> 
> On 01/14/2014 07:12 AM, Felipe Balbi wrote:
> >On Mon, Jan 13, 2014 at 06:19:24PM -0600, Suman Anna wrote:
> >>HwSpinlocks are supported on AM33xx, AM43xx and DRA7xx SoC
> >>device families as well. The IPs are identical to that of
> >>OMAP4/OMAP5, except for the number of locks.
> >>
> >>Add a depends on to the above family of SoCs to enable the
> >>build support for OMAP hwspinlock driver for any of the above
> >>SoC configs.
> >>
> >>Signed-off-by: Suman Anna <s-anna@ti.com>
> >>---
> >>  drivers/hwspinlock/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >>diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
> >>index 70637d2..3612cb5 100644
> >>--- a/drivers/hwspinlock/Kconfig
> >>+++ b/drivers/hwspinlock/Kconfig
> >>@@ -10,7 +10,7 @@ menu "Hardware Spinlock drivers"
> >>
> >>  config HWSPINLOCK_OMAP
> >>  	tristate "OMAP Hardware Spinlock device"
> >>-	depends on ARCH_OMAP4 || SOC_OMAP5
> >>+	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX || SOC_AM33XX || SOC_AM43XX
> >
> >how about just using ARCH_OMAP2PLUS ?
> 
> We do not want the driver to build in OMAP2-only and/or OMAP3-only
> configurations, on which the hwspinlock IP is not even present.

It won't be enabled by default, will it ? You're just saying that it
_can_ be enabled. In fact, I would go one step further and use:

	depends on ARCH_OMAP2PLUS || COMPILE_TEST

your choice though ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140114/05d03c96/attachment.sig>
