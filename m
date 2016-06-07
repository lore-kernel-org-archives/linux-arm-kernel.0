From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 7 Jun 2016 18:38:37 +0800
Subject: [Query] do we need to patch arch/arm64/Makefile for ca53 errata843419
Message-ID: <20160607183837.7618dcc6@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

Per my understanding, newer aarch64 toolchain enable fix cortex-a53-843419
when configuring, but this only means gcc will pass "--fix-cortex-a53-843419"
to ld by default, however the linux kernel LD cmd ld rather than gcc, so
do we need to add something like the following into arch/arm64/Makefile?

ifeq ($(CONFIG_ARM64_ERRATUM_843419), y)
LDFLAGS_vmlinux += $(call ld-option, --fix-cortex-a53-843419)
endif

Thanks,
Jisheng
