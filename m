From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 2 Nov 2018 17:26:51 +0000
Subject: [PATCH] arm64: makefile fix build of .i file in external module
 case
In-Reply-To: <20181030233710.5529-1-kamensky@cisco.com>
References: <20181030233710.5529-1-kamensky@cisco.com>
Message-ID: <20181102172651.GF218059@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2018 at 04:37:10PM -0700, Victor Kamensky wrote:
> After 'a66649dab350 arm64: fix vdso-offsets.h dependency' if
> one will try to build .i file in case of external kernel module,
> build fails complaining that prepare0 target is missing. This
> issue came up with SystemTap when it tries to build variety
> of .i files for its own generated kernel modules trying to
> figure given kernel features/capabilities.
> 
> The issue is that prepare0 is defined in top level Makefile
> only if KBUILD_EXTMOD is not defined. .i file rule depends
> on prepare and in case KBUILD_EXTMOD defined top level Makefile
> contains empty rule for prepare. But after mentioned commit
> arch/arm64/Makefile would introduce dependency on prepare0
> through its own prepare target.
> 
> Fix it to put proper ifdef KBUILD_EXTMOD around code introduced
> by mentioned commit. It matches what top level Makefile does.
> 
> Signed-off-by: Victor Kamensky <kamensky@cisco.com>

Queued for 4.20. Thanks.

-- 
Catalin
