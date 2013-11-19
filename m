From: horms@verge.net.au (Simon Horman)
Date: Tue, 19 Nov 2013 12:32:33 +0900
Subject: [PATCH] ARM: shmobile: Use ->init_late() on Lager
In-Reply-To: <20131118085953.GF1506@verge.net.au>
References: <20131113223406.20634.52693.sendpatchset@w520>
 <20131118085953.GF1506@verge.net.au>
Message-ID: <20131119033231.GB30900@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 05:59:55PM +0900, Simon Horman wrote:
> On Thu, Nov 14, 2013 at 07:34:06AM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Hook in shmobile_init_late() on Lager. This enables some PM
> > related things like CPUIdle and Suspend-to-RAM.
> > 
> > With this patch applied it is possible to use Suspend-to-RAM:
> > # echo enabled > /sys/class/tty/ttySC6/power/wakeup
> > # echo mem > /sys/power/state 
> > (wake by sending a character on the serial console)
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Thanks, I will queue this up.

Hi Magnus,

it seems that this patch needs the following so that shmobile_init_late
is defined. I am dropping this patch for now.

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index ac01118..51a3bcc 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -20,6 +20,7 @@
 
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <mach/common.h>
 #include <mach/rcar-gen2.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
