From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 29 Oct 2016 23:54:08 +0200
Subject: [PATCH] asm-generic: Drop getrlimit and setrlimit syscalls from
 default list
In-Reply-To: <1477138444-14993-1-git-send-email-ynorov@caviumnetworks.com>
References: <1477138444-14993-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <5823871.3DMLUx5Xtp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, October 22, 2016 3:14:04 PM CEST Yury Norov wrote:
> The newer prlimit64 syscall provides all the functionality provided by
> the getrlimit and setrlimit syscalls and adds the pid of target process,
> so future architectures won't need to include getrlimit and setrlimit.
> 
> Therefore drop getrlimit and setrlimit syscalls from the generic syscall
> list unless __ARCH_WANT_SET_GET_RLIMIT is defined by the architecture's
> unistd.h prior to including asm-generic/unistd.h, and adjust all
> architectures using the generic syscall list to define it so that no
> in-tree architectures are affected.
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

Can you include this patch in your ilp32 series?
