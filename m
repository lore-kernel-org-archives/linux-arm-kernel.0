From: alex@gai.ru (Alex Sverdlin)
Date: Sat, 09 Oct 2010 13:32:39 +0400
Subject: cmpxchg() in recent kernels
Message-ID: <4CB036B7.7000100@gai.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

I've probably missed something, but how to compile recent kernels on ARM?
I've been using GCC 3.4.3 from Cirrus for my EP9302 boards up to 2.6.35.4
But 2.6.36-rc and upper won't compile anymore.
The problem is appearing in multiplatform code of cmpxchg() function.
First in kernel/pid.c (2.6.36-rc4 - 2.6.36-rc6)
Then 4 times in 2.6.36-rc7-next... atomic_cmpxchg compiles fine, and when I
replace cmpxhg with atomic_ version, everything compiles fine.

Here is output of make from 2.6.36-rc7-next:
...
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      vmlinux
kernel/built-in.o: In function `alloc_pid':
elfcore.c:(.text+0x1c258): undefined reference to `wrong_size_cmpxchg'
net/built-in.o: In function `rt_bind_peer':
sysctl_net.c:(.text+0x3bb38): undefined reference to `wrong_size_cmpxchg'
net/built-in.o: In function `inet_add_protocol':
sysctl_net.c:(.text+0x3f4dc): undefined reference to `wrong_size_cmpxchg'
net/built-in.o: In function `inet_del_protocol':
sysctl_net.c:(.text+0x3f5a8): undefined reference to `wrong_size_cmpxchg'
net/built-in.o: In function `build_ehash_secret':
sysctl_net.c:(.text+0x6a034): undefined reference to `wrong_size_cmpxchg'
make[1]: *** [vmlinux] Error 1
...

Best regards!
