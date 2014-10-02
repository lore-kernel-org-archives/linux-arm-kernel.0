From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Oct 2014 16:52:18 +0100
Subject: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <1409779158-30963-1-git-send-email-apinski@cavium.com>
References: <1409779158-30963-1-git-send-email-apinski@cavium.com>
Message-ID: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 10:18:54PM +0100, Andrew Pinski wrote:
> New version with all of the requested changes.  Updated to the latest sources.
> 
> Notable changes from the previous versions:
> VDSO code has been factored out to be easier to understand and easier to maintain.
> Move the config option to the last thing that gets added.
> Added some extra COMPAT_* macros for core dumping for easier usage.

Apart from a few comments I've made, I would also like to see non-empty
commit logs and long line wrapping (both in commit logs and
Documentation/). Otherwise, the patches look fine.

So what are the next steps? Are the glibc folk ok with the ILP32 Linux
ABI? On the kernel side, what I would like to see:

1. LTP results (in all combinations of AArch32, LP64, ILP32, big and
   little endian)
2. A way for us to reproduce the ILP32 tests - at which point could we
   get a toolchain? Ideally a filesystem as well, though maybe we could
   just use a busybox in the meantime.

Thanks.

-- 
Catalin
