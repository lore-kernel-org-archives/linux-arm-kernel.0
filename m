From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Jun 2014 11:10:39 +0100
Subject: [PATCH] arm64: fix build error in sigcontext.h
In-Reply-To: <1402517682-13061-1-git-send-email-msalter@redhat.com>
References: <1402517682-13061-1-git-send-email-msalter@redhat.com>
Message-ID: <20140618101039.GA14680@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 09:14:42PM +0100, Mark Salter wrote:
> I'm seeing this build failure for arm64:
> 
>     CC [M]  Documentation/filesystems/configfs/configfs_example_macros.o
>   In file included from /usr/include/bits/sigcontext.h:27:0,
>                    from /usr/include/signal.h:340,
>                    from /usr/include/sys/wait.h:30,
>                    from Documentation/accounting/getdelays.c:24:
>   .../linux/usr/include/asm/sigcontext.h:61:2: error: unknown type name ?u64?
>     u64 esr;
>     ^
>   make[2]: *** [Documentation/accounting/getdelays] Error 1
> 
> This was introduced by commit 15af1942dd61ee23:
> 
>   arm64: Expose ESR_EL1 information to user when SIGSEGV/SIGBUS
> 
> Using __u64 instead of u64 fixes the problem.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>

Applied. Thanks.

-- 
Catalin
