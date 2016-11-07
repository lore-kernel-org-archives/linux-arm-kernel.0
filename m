From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 7 Nov 2016 13:53:59 +0530
Subject: ILP32 for ARM64: testing with glibc testsuite
In-Reply-To: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20161107082359.GA19666@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

[add libc-alpha mail list]

For libc-alpha: this is the part of LKML submission with latest
patches for aarch64/ilp32.
https://www.spinics.net/lists/arm-kernel/msg537846.html

Glibc that I use has also included consolidation patches from Adhemerval
Zanella and me that are still not in the glibc master. The full series is:
https://github.com/norov/glibc/tree/ilp32-2.24-dev2

Below is the results of glibc testsuite run for aarch64/lp64
in different configurations. Column names meaning:
kvgv: kernel is vanilla, glibc is vanilla;
kdgv: kernel has ilp32 patches applied, but ilp32 is disabled in config; 
      glibc is vanilla;
kegv: kernel has ilp32 patches applied and ilp32 is enabled, glibc is vanilla;
kege: kernel patches are applied and enabled, glibc patches are applied.

Only different lines are shown. Full results are in attached archive. 

I didn't analyze regressions deep yet, so any ideas/suggestions are appreciated.

Yury.

Test					kvgv	kdgv	kegv	kege
conform/ISO/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL
conform/ISO11/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL
conform/ISO99/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL
conform/POSIX/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL
conform/POSIX/sys/stat.h/linknamespace	PASS 	PASS 	PASS	FAIL
conform/UNIX98/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL
conform/XOPEN2K/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL
conform/XPG3/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL
conform/XPG4/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL
csu/tst-atomic				PASS 	PASS 	PASS	FAIL
elf/check-localplt			PASS 	PASS 	PASS	FAIL
iconvdata/mtrace-tst-loading		PASS	FAIL	PASS 	PASS
iconvdata/tst-loading			PASS	FAIL	PASS 	PASS
io/check-installed-headers-c		PASS 	PASS 	PASS	FAIL
io/check-installed-headers-cxx		PASS 	PASS 	PASS	FAIL
malloc/tst-malloc-backtrace		FAIL	PASS	PASS	PASS
malloc/tst-malloc-thread-exit		FAIL	PASS	PASS	PASS
malloc/tst-malloc-usable		FAIL	PASS	PASS	PASS
malloc/tst-mallocfork			FAIL	PASS	PASS	PASS
malloc/tst-mallocstate			FAIL	PASS	PASS	PASS
malloc/tst-mallopt			FAIL	PASS	PASS	PASS
malloc/tst-mcheck			FAIL	PASS	PASS	PASS
malloc/tst-memalign			FAIL	PASS	PASS	PASS
malloc/tst-obstack			FAIL	PASS	PASS	PASS
malloc/tst-posix_memalign		FAIL	PASS	PASS	PASS
malloc/tst-pvalloc			FAIL	PASS	PASS	PASS
malloc/tst-realloc			FAIL	PASS	PASS	PASS
malloc/tst-scratch_buffer		FAIL	PASS	PASS	PASS
malloc/tst-trim1			FAIL	PASS	PASS	PASS
nptl/tst-eintr4				PASS 	PASS 	PASS	NA
posix/tst-regex2			PASS	FAIL	FAIL	FAIL
posix/tst-getaddrinfo4			PASS	PASS	FAIL	FAIL
posix/tst-getaddrinfo5			PASS	PASS	FAIL	FAIL
sysvipc/test-sysvmsg			NA	NA	NA	FAIL
sysvipc/test-sysvsem			NA	NA	NA	FAIL
sysvipc/test-sysvshm			NA	NA	NA	FAIL
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lp64.sum.tar.gz
Type: application/gzip
Size: 37007 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/ad049b89/attachment-0001.gz>
