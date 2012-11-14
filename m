From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 14 Nov 2012 13:06:53 -0600
Subject: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
In-Reply-To: <20121114185335.GU6801@atomide.com>
References: <20121114185335.GU6801@atomide.com>
Message-ID: <50A3EBCD.3040801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/14/2012 12:53 PM, Tony Lindgren wrote:
> Looks like enabling CONFIG_ARM_ERRATA_751472 causes omap4 blaze
> to not boot when enabled. The ARM core on it is an earlier r1p2:
> 
> CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7d
> 
> Unfortunately I don't have the details of errata 751472, but I'm
> guessing we need to disable it for r1p*.

I checked the CA9MP errata document and this erratum impacts all
r0/r1/r2 CPUs. I am wondering if the problem is because the workaround
requires you to set a bit in the Diagnostic Control register and the
read-modify-write sequence provided in the workaround is for secure
mode. Not sure if there is a non-secure workaround available :-(

Cheers
Jon
