From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 12 Jul 2016 10:41:58 +0900
Subject: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160712014201.11456-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree blob must be passed to a second kernel on DTB-capable
archs, like powerpc and arm64, but the current kernel interface
lacks this support.
  
This patch extends kexec_file_load system call by adding an extra
argument to this syscall so that an arbitrary number of file descriptors
can be handed out from user space to the kernel.

See the background [1].

Please note that the new interface looks quite similar to the current
system call, but that it won't always mean that it provides the "binary
compatibility."

[1] http://lists.infradead.org/pipermail/kexec/2016-June/016276.html


AKASHI Takahiro (3):
  syscall: add kexec_file_load to generic unistd.h
  kexec: add dtb info to struct kimage
  kexec: extend kexec_file_load system call

 include/linux/fs.h                |  1 +
 include/linux/kexec.h             |  5 +++-
 include/linux/syscalls.h          |  4 ++-
 include/uapi/asm-generic/unistd.h |  8 ++++-
 include/uapi/linux/kexec.h        | 17 +++++++++++
 kernel/kexec_file.c               | 62 ++++++++++++++++++++++++++++++++++-----
 6 files changed, 87 insertions(+), 10 deletions(-)

-- 
2.9.0
