From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 18 Aug 2015 20:31:31 +0200
Subject: [PATCH v2 01/21] ARM: pxa: magician: Fix Kconfig for magician to
 always include htc-egpio
In-Reply-To: <55D25880.3030507@tul.cz> (Petr Cvek's message of "Mon, 17 Aug
 2015 23:56:16 +0200")
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25880.3030507@tul.cz>
Message-ID: <87zj1o8n3w.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> The htc-egpio driver should be always included in the kernel as it
> controls MMC/charging/IrDA power, which is the only way to get
> an useful rootfs.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
It's already defined in magician_defconfig, why enforce it in Kconfig ?

And if it's enforced and I want to build a kernel for magician without
MMC/charging/IrDA, why should I be forced to build in HTC_EGPIO ?

Or said differently, does a kernel without HTC_EGPIO is proven to fail 100%
without this option ?

Cheers.

-- 
Robert
