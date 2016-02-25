From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Thu, 25 Feb 2016 09:54:09 +0100
Subject: [PATCH v2 0/5] all: s390: make compat wrappers the generic
 solution
In-Reply-To: <1456338854-14901-1-git-send-email-ynorov@caviumnetworks.com>
References: <1456338854-14901-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20160225085409.GE3980@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 09:34:09PM +0300, Yury Norov wrote:
> The problem that makes us use wrappers is that some compat
> architectures allows user code to access top halves of registers.
> This is not a problem for syscalls that are already handled by compat
> code, or for that who has types of the same size in kernel and
> userspace. In case of s390 and lp64/ilp32 the problem is in pointer
> types, long, unsigned long.
> 
> S390 folks already have the solution for it. In this patchset,
> it is turned to be general, as arm64/ilp32 needs it too.
> 
> This patchset is created as the part of the work of enabling arm64
> with ILP32 user mode. See details here:
> http://thread.gmane.org/gmane.linux.kernel/2126946
> 
> This is the implementation of one of two possible approaches. First
> one defines new syscall handler declaration macro, that creates both compat and
> non-compat handlers, see [1]. This one declares all wrappers in separated file
> kernel/compat_wrapper.c
> 
> Build-tested on s390.
> 
> [1] http://www.spinics.net/lists/linux-s390/msg11593.html
> 
> Yury Norov (5):
>   all: syscall wrappers: add documentation
>   all: introduce COMPAT_WRAPPER option and enable it for s390
>   all: s390: move wrapper infrastructure to generic headers
>   all: s390: move compat_wrappers.c from arch/s390/kernel to kernel/
>   all: wrap needed syscalls in generic unistd

Looks good to me. You may consider the possible changes I sent as reply to
some of your patches.
However from an s390 point of view:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
