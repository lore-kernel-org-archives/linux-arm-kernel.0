From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Dec 2012 18:04:42 +0000
Subject: [PATCH 2/7] arm64: Add dtbs target for building all the
 enabled dtb files
In-Reply-To: <50C263EC.70209@gmail.com>
References: <1354914392-9634-1-git-send-email-catalin.marinas@arm.com>
 <1354914392-9634-3-git-send-email-catalin.marinas@arm.com>
 <50C263EC.70209@gmail.com>
Message-ID: <20121210180442.GA691@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 07, 2012 at 09:47:24PM +0000, Rob Herring wrote:
> On 12/07/2012 03:06 PM, Catalin Marinas wrote:
> > Based on Rob Herring's patches for arch/arm, this patch adds a dtbs
> > target to arch/arm64/boot/Makefile. In the process, also clean up the
> > unused MACHINE variable.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> > 
> > I'll drop this patch once Rob pushes his version into linux-next (or
> > mainline).
> 
> This and Stephen's dtb rule series are in linux-next now.

One minor fix needed. Please merge or fold it, whatever is easier.
Thanks.

-----------------------8<------------------------------

>From addc6b45f915f6bbab238a2edd2072f3b474e673 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 21 Nov 2012 11:44:59 +0000
Subject: [PATCH] arm64: Fix the dtbs target building

The arch/arm64/Makefile was not passing the right target to the
boot/dts/Makefile.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 11c3599..c95c5cb 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -58,7 +58,7 @@ zinstall install: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot)/dts $(boot)/dts/$@
 
 dtbs: scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts $(boot)/dts/$@
+	$(Q)$(MAKE) $(build)=$(boot)/dts dtbs
 
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
