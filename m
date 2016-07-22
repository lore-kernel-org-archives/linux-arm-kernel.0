From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 22 Jul 2016 18:03:35 +0200
Subject: [PATCH] arm64: Kconfig: select ALPINE_MSI only if PCI is selected
In-Reply-To: <180e7e82-13cc-7fda-fbb1-2f2b43e75271@arm.com>
References: <1469198527-12525-1-git-send-email-sudeep.holla@arm.com>
 <20160722152730.GC6397@kwain>
 <180e7e82-13cc-7fda-fbb1-2f2b43e75271@arm.com>
Message-ID: <20160722160335.GD6397@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2016 at 04:36:41PM +0100, Sudeep Holla wrote:
> On 22/07/16 16:27, Antoine Tenart wrote:
> >
> >On Fri, Jul 22, 2016 at 03:42:07PM +0100, Sudeep Holla wrote:
> >>Even when PCI is disabled, ARCH_ALPINE selects ALPINE_MSI triggerring
> >>the following config warning:
> >>
> >>warning: (ARCH_ALPINE) selects ALPINE_MSI which has unmet direct dependencies (PCI)
> >>
> >>This patch makes selection of ALPINE_MSI conditional on PCI.
> >
> >[...]
> >
> >>--- a/arch/arm64/Kconfig.platforms
> >>+++ b/arch/arm64/Kconfig.platforms
> >>@@ -8,7 +8,7 @@ config ARCH_SUNXI
> >>
> >> config ARCH_ALPINE
> >> 	bool "Annapurna Labs Alpine platform"
> >>-	select ALPINE_MSI
> >>+	select ALPINE_MSI if PCI
> >> 	help
> >> 	  This enables support for the Annapurna Labs Alpine
> >> 	  Soc family.
> >
> >ALPINE_MSI also depends on PCI_MSI (which itself depends on PCI).
> 
> ALPINE_MSI now selects PCI_MSI

You're right, I didn't look at -next. As you mentioned ALPINE_MSI now
selects PCI_MSI.

So,

Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160722/0d39e839/attachment-0001.sig>
