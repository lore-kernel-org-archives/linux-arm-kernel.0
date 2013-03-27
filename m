From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Mar 2013 11:55:09 +0000
Subject: [Suggestion] ARM64:kernel: compiling issue for early_console.
In-Reply-To: <5152DB83.8080703@asianux.com>
References: <5152DB83.8080703@asianux.com>
Message-ID: <20130327115509.GA1603@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 11:44:03AM +0000, Chen Gang wrote:
>   the error message:
>     arch/arm64/kernel/early_printk.c: At top level:
>     arch/arm64/kernel/early_printk.c:98:23: error: conflicting types for ?early_console?
>     In file included from arch/arm64/kernel/early_printk.c:20:0:
>     include/linux/console.h:145:24: note: previous declaration of ?early_console? was here
>     make[1]: *** [arch/arm64/kernel/early_printk.o] Error 1
>     make: *** [arch/arm64/kernel] Error 2

Is this in linux-next? Mainline seems fine.

I saw some patches from tglx on unifying the various early printk
implementations, though not sure whether it's those patches causing it
(in which case arm64 needs to be updated as well).

-- 
Catalin
