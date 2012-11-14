From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Nov 2012 19:01:37 +0000
Subject: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
In-Reply-To: <20121114185335.GU6801@atomide.com>
References: <20121114185335.GU6801@atomide.com>
Message-ID: <20121114190137.GD3332@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 10:53:35AM -0800, Tony Lindgren wrote:
> Looks like enabling CONFIG_ARM_ERRATA_751472 causes omap4 blaze
> to not boot when enabled. The ARM core on it is an earlier r1p2:
> 
> CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7d
> 
> Unfortunately I don't have the details of errata 751472, but I'm
> guessing we need to disable it for r1p*.

Fails because it can't write the diagnostic register from non-secure
mode or fails later?
