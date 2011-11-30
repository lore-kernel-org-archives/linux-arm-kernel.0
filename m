From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 30 Nov 2011 11:14:00 +0000
Subject: [PATCH v3 0/5] Versatile Express DT support
In-Reply-To: <20111130104842.GA2045@localhost.localdomain>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <20111129170013.GD2829@localhost.localdomain>
 <1322587019.3164.111.camel@hornet.cambridge.arm.com>
 <20111130104842.GA2045@localhost.localdomain>
Message-ID: <1322651640.3164.135.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-30 at 10:48 +0000, Dave Martin wrote:
> Attached.  It's just vexpress_defconfig, plus ARCH_VEXPRESS_V2P_CA5S_CA9=y

Could you try that?

8<----------------------------------------------
diff --git a/arch/arm/mach-vexpress/Kconfig
b/arch/arm/mach-vexpress/Kconfig
index 9eb8161..ded66d0 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -11,7 +11,7 @@ config ARCH_VEXPRESS_CA9X4
 
 config ARCH_VEXPRESS_DT
        bool
-       select OF
+       select USE_OF
        help
          VE platform *requiring* Flattened Device Tree to boot.
8<----------------------------------------------

The OF is an effect of the USE_OF, not the other way round, sorry about
the mistake.

Of course I could go the "classic way" and make the
ARCH_VEXPRESS_V2P_CA5S_CA9 dependant on the OF, but this means that the
DT-powered tile would be invisible till one enables USE_OF. Any
opinions?

Cheers!

Pawe?
