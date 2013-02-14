From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 14 Feb 2013 16:45:05 -0700
Subject: [PATCH 8/9] [HACK] ARM: imx: work around v7_cpu_resume link error
In-Reply-To: <1360882071-4072668-9-git-send-email-arnd@arndb.de>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
 <1360882071-4072668-9-git-send-email-arnd@arndb.de>
Message-ID: <511D7701.8040809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2013 03:47 PM, Arnd Bergmann wrote:
> Patch c08e20d24 "arm: Add v7_invalidate_l1 to cache-v7.S"
> moves the v7_invalidate_l1 symbol out of imx/headsmp.S,
> which seems to cause a link error because it is now
> too far away from v7_cpu_resume when building an
> allyesconfig kernel.

Is the problem from the following in arch/arm/mach-imx/headsmp.S:

ENTRY(v7_cpu_resume)
        bl      v7_invalidate_l1

Isn't the range of bl +/- 32MiB (or +/- 16MibB in Thumb 2). Is the
kernel really that big? Sorry, I'm having trouble understanding what
causes the problem.
