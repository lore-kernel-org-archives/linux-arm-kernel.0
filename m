From: wcohen@redhat.com (William Cohen)
Date: Tue, 29 May 2012 10:45:58 -0400
Subject: [PATCH] Avoid needing export of include/asm-generic/kvm_para.h
Message-ID: <1338302759-12364-1-git-send-email-wcohen@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel build checks (header_checks.pl) to verify that installed include
files do not include uninstalled files. When attempting to build the mainline
kernel from the git repository the build would fail on ARM machines
because these checks would determine that the ARM's version of kvm_para.h
was including asm-generic/kvm_para.h which is not installed.  
The asm-generic/kvm_para.h didn't seem to have anything that really should
be visible outside, so made arm use a generated head file instead.

It looks like similiar patches may be be needed for other architectures due
to commit 3b5d56b9317fa7b5407dff1aa7b115bf6cdbd494 (kvmclock: Add functions
to check if the host has stopped the vm)

William Cohen (1):
  Avoid needing export of include/asm-generic/kvm_para.h

 arch/arm/include/asm/Kbuild     |    1 +
 arch/arm/include/asm/kvm_para.h |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)
 delete mode 100644 arch/arm/include/asm/kvm_para.h

-- 
1.7.10.1
