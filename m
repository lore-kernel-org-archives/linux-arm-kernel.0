From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun, 9 Apr 2017 00:02:58 +0800 (CST)
Subject: Linux next-20170407 failed to build on ARM due to usage of mod in
 btrfs code
Message-ID: <alpine.LNX.2.20.1704090002520.35546@x220i>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,
Today I tried to build a kernel with btrfs enabled on ARM, then when 
linking I met such an error:

```
fs/built-in.o: In function `scrub_bio_end_io_worker':
acl.c:(.text+0x2f0450): undefined reference to `__aeabi_uldivmod'
fs/built-in.o: In function `scrub_extent_for_parity':
acl.c:(.text+0x2f0bcc): undefined reference to `__aeabi_uldivmod'
fs/built-in.o: In function `scrub_raid56_parity':
acl.c:(.text+0x2f12a8): undefined reference to `__aeabi_uldivmod'
acl.c:(.text+0x2f15c4): undefined reference to `__aeabi_uldivmod'
```

These functions are found at fs/btrfs/scrub.c .

After disabling btrfs the kernel is successfully built.

For this problem, see also [1], which used to be a similar bug in PL330 
driver code.

[1] https://patchwork.kernel.org/patch/5299081/

Thanks,
Icenowy
