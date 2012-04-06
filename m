From: ijc@hellion.org.uk (Ian Campbell)
Date: Fri, 06 Apr 2012 19:32:22 +0100
Subject: [PATCH] ARM: kirkwood: add missing kexec.h include
In-Reply-To: <4F7F2BA2.9040308@mvista.com>
References: <1333715458-13834-1-git-send-email-ijc@hellion.org.uk>
 <4F7EE6AE.4020909@mvista.com>
 <1333717838.12209.83.camel@dagon.hellion.org.uk>
 <4F7F2BA2.9040308@mvista.com>
Message-ID: <1333737142.12209.97.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-04-06 at 21:45 +0400, Sergei Shtylyov wrote:
> On 04/06/2012 05:10 PM, Ian Campbell wrote:
> 
> >>> Fixes build the following error when CONFIG_KEXEC is enabled:
> 
> >>      Maybe "the following build error" instead?
> 
> > Done.
> 
>    Not quite. Still "fixes build the following...". :-)

Duh, yeah, of course.

Lets try again...

8<--------------------------------------------

>From e8437c14cb0dc23cc8db30a0f596d0cc8dbd28ef Mon Sep 17 00:00:00 2001
From: Ian Campbell <ijc@hellion.org.uk>
Date: Fri, 6 Apr 2012 13:27:23 +0100
Subject: [PATCH] ARM: kirkwood: add missing kexec.h include

Fixes the following build error when CONFIG_KEXEC is enabled:

  CC      arch/arm/mach-kirkwood/board-dt.o
arch/arm/mach-kirkwood/board-dt.c: In function 'kirkwood_dt_init':
arch/arm/mach-kirkwood/board-dt.c:52:2: error: 'kexec_reinit' undeclared (first use in this function)
arch/arm/mach-kirkwood/board-dt.c:52:2: note: each undeclared identifier is reported only once for each function it appears in

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
[v3, speak actual English in the commit message, thanks Sergei Shtylyov]
[v2, using linux/kexec.h not asm/kexec.h]
---
 arch/arm/mach-kirkwood/board-dt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index d3cf5e6..23da042 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/kexec.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/bridge-regs.h>
-- 
1.7.8.3


-- 
Ian Campbell


Whenever I date a guy, I think, is this the man I want my children
to spend their weekends with?
		-- Rita Rudner
