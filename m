From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu,  8 Mar 2018 22:20:53 -0500
Subject: [PATCH 0/7] further linker script cleanups
Message-ID: <20180309032100.31039-1-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series continues on the linker script cleanups that were started in
commit 0d302c710b ("ARM: vmlinux-xip.lds.S: fix multiple issues"). Many
duplications between the XIP and non-XIP scripts are factored out in a
common file, and the TCM support with an XIP kernel is now possible.

This makes for a nice diffstat:

 arch/arm/kernel/vmlinux-xip.lds.S | 166 ++----------------------------
 arch/arm/kernel/vmlinux.lds.S     | 172 ++------------------------------
 arch/arm/kernel/vmlinux.lds.h     | 135 +++++++++++++++++++++++++
 arch/arm/mm/init.c                |  11 --
 4 files changed, 156 insertions(+), 328 deletions(-)

Alsoavailable here:

  git://git.linaro.org/people/nicolas.pitre/linux lds
