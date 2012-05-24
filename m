From: arend@broadcom.com (Arend van Spriel)
Date: Thu, 24 May 2012 15:13:15 +0200
Subject: Linux Kernel boot up stops after message
 "Uncompressing Linux....done, booting the kernel"
In-Reply-To: <CACZ0kf9yHJOAVEBx4e5dc_eCRT5dScrZHzbkx3_7P2QkzaHChQ@mail.gmail.com>
References: <CACZ0kf88Ac8hne9RtLObi624okPw8Nkiv7++Uw8npPLW108mhw@mail.gmail.com>
 <CACZ0kf9yHJOAVEBx4e5dc_eCRT5dScrZHzbkx3_7P2QkzaHChQ@mail.gmail.com>
Message-ID: <4FBE33EB.3090709@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2012 07:22 AM, K K wrote:
> Hi,
> 
> We have a lpc-3180 based board and it is up and running fine with 2.6.10
> kernel version. We planned to port our board changes into 2.6.32 kernel
> version.
> 
> As a part of this, we added the architecture dependent  code  (mach
> files)  first. Then we changed some of the kernel upgradations.
> 
> kernel build successfully. When we booting the board with the new 2.6.32
> kernel we are getting following messages and its stops.

I had a similar issue with a Pandaboard and I needed to patch u-boot:

diff --git a/include/configs/omap4_common.h b/include/configs/omap4_common.h
index d8ac8c0..89f9e89 100644
--- a/include/configs/omap4_common.h
+++ b/include/configs/omap4_common.h
@@ -36,6 +36,7 @@
 #define CONFIG_OMAP44XX                1       /* which is a 44XX */
 #define CONFIG_OMAP4430                1       /* which is in a 4430 */
 #define CONFIG_ARCH_CPU_INIT
+#define CONFIG_SYS_DCACHE_OFF  1       /* not d-cache in u-boot */

 /* Get CPU defs */
 #include <asm/arch/cpu.h>


Gr. AvS
