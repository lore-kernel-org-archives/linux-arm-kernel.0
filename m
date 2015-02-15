From: wangnan0@huawei.com (Wang Nan)
Date: Sun, 15 Feb 2015 16:26:38 +0800
Subject: [RFC PATCH 0/3] early kprobes: rearrange vmlinux.lds related code.
In-Reply-To: <20150213173244.GE8656@n2100.arm.linux.org.uk>
References: <20150213173244.GE8656@n2100.arm.linux.org.uk>
Message-ID: <1423988798-7104-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of early kprobes patch series update. Full series can be
found from [1].

Early kprobes need some statically allocated slots, which is determined
during linking by vmlinux.lds.S. Russell King suggests me not to spread
vmlinux stuff around the kernel include files. This series tries to
extract common code to include/asm-generic/vmlinux.lds.h and let arch
dependent code define macros common code requires.

[1]: https://lkml.org/lkml/2015/2/13/24

Wang Nan (3):
  early kprobes: ARM: add definition for vmlinux.lds use.
  early kprobes: x86: add definition for vmlinux.lds use.
  early kprobes: introduce early kprobes related code area.

 arch/arm/kernel/vmlinux.lds.S     | 10 ++++++++++
 arch/x86/kernel/vmlinux.lds.S     | 10 ++++++++++
 include/asm-generic/vmlinux.lds.h | 19 ++++++++++++++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
1.8.4
