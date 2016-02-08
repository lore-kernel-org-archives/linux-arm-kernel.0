From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 8 Feb 2016 17:28:22 +0000
Subject: [PATCH] arm64: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
In-Reply-To: <56B8CBDA.4050107@linaro.org>
References: <1454716218-4918-1-git-send-email-yang.shi@linaro.org>
 <20160208114649.GB13498@leverpostej> <56B8CBDA.4050107@linaro.org>
Message-ID: <20160208172822.GC15443@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 09:09:46AM -0800, Shi, Yang wrote:
> On 2/8/2016 3:46 AM, Mark Rutland wrote:
> >Hi,
> >
> >On Fri, Feb 05, 2016 at 03:50:18PM -0800, Yang Shi wrote:
> >>To enable UBSAN on arm64, ARCH_HAS_UBSAN_SANITIZE_ALL need to be selected.
> >>
> >>Basic kernel bootup test is passed on arm64 with CONFIG_UBSAN_SANITIZE_ALL
> >>enabled.
> >>
> >>Signed-off-by: Yang Shi <yang.shi@linaro.org>
> >>---
> >>  arch/arm64/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >>diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >>index 8cc6228..1c29e20 100644
> >>--- a/arch/arm64/Kconfig
> >>+++ b/arch/arm64/Kconfig
> >>@@ -14,6 +14,7 @@ config ARM64
> >>  	select ARCH_WANT_OPTIONAL_GPIOLIB
> >>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
> >>  	select ARCH_WANT_FRAME_POINTERS
> >>+	select ARCH_HAS_UBSAN_SANITIZE_ALL
> >>  	select ARM_AMBA
> >>  	select ARM_ARCH_TIMER
> >>  	select ARM_GIC
> >
> >I gave this a go, and I got a couple of splats (included below) when
> >booting an Ubuntu 14.04 arm64 rootfs. I'm using Linato 15.08 GCC 5.1 to
> >compile an arm64 defconfig, and I see the issue with v4.5-rc2 and
> >v4.5-rc3.
> >
> >I will dig into that and file a report shortl, unless someone has
> >already reported the same issue.
> >
> >Did you see any failures in your testing? For reference, which kernel
> >version, compiler, and config were you using?
> 
> Yes, I did. I'm using 4.5-rc1 with gcc 5.2. And, I got one more
> splat and was digging into it.

Ok. Glad to hear it's not just me seeing it.

In future it would be best to point out issues you've spotted so that
reviewers don't confuse them for false positives.

Thanks,
Mark.
