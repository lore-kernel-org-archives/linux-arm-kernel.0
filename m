From: js07.lee@samsung.com (Jungseung Lee)
Date: Thu, 21 Apr 2016 22:49:13 +0900
Subject: [PATCH] s390/compat: build error for large compat syscall args
Message-ID: <00ef01d19bd4$9710aec0$c5320c40$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> s390/compat: build error for large compat syscall args
>
>   Enforce 32 bit types for all compat syscall argument types.
>
>   This way we can make sure that all arguments get correct sign
>   or zero extension. Otherwise incorrect code would be generated.
>
>   E.g. for a 'long' type the COMPAT_SYSCALL_DEFINE macro wouldn't
>   generate code that would cause sign extension of the passed in 32
>   bit user space parameter.
>   This can cause quite subtle bugs like e.g. the one that was fixed
>   with dfd948e32af2e "fs/compat: fix parameter handling for compat
>   readv/writev syscalls".

include/linux/compat.h
#ifndef __SC_DELOUSE
#define __SC_DELOUSE(t,v) ((t)(unsigned long)(v)) #endif

We couldn't make sure that all compat syscall arguments has
32 bit types with default definition.
Is there any reason that this patch is only applied for s390?

Please let me know if I miss something.

BR
