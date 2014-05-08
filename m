From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 8 May 2014 13:05:09 -0400
Subject: [PATCH linux-next] ARM: mvebu: Fix pmsu compilation when ARMv6
 is selected
In-Reply-To: <1399407782-29091-1-git-send-email-vincent.stehle@laposte.net>
References: <1399407782-29091-1-git-send-email-vincent.stehle@laposte.net>
Message-ID: <20140508170509.GJ12708@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 06, 2014 at 10:23:02PM +0200, Vincent Stehl? wrote:
> When compiling for multiplatform for both ARMv6 and ARMv7, the default compiler
> flags are for ARMv6, and we will get:
> 
>   /tmp/ccwDEzd0.s: Assembler messages:
>   /tmp/ccwDEzd0.s:639: Error: selected processor does not support ARM mode `isb '
>   /tmp/ccwDEzd0.s:645: Error: selected processor does not support ARM mode `isb '
>   /tmp/ccwDEzd0.s:646: Error: selected processor does not support ARM mode `dsb '
>   /tmp/ccwDEzd0.s:695: Error: selected processor does not support ARM mode `isb '
>   make[1]: *** [arch/arm/mach-mvebu/pmsu.o] Error 1
> 
> Fix this in a similar manner than done previously in commit
> 72533b77d30c2be02672e26b5dde1263d7b4c2be, by specifying ARMv7 flags for pmsu.o.
> 
> Signed-off-by: Vincent Stehl? <vincent.stehle@laposte.net>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> ---
> 
> Hi,
> 
> This build issue can be seen with e.g. Linux next-20140506, ARCH=arm and
> allmodconfig.
> 
> Best regards,
> 
> V.
> 
>  arch/arm/mach-mvebu/Makefile | 1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/soc, thanks!

thx,

Jason.
