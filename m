From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 14 Mar 2018 11:54:06 -0400 (EDT)
Subject: [GIT PULL] further linker script cleanups
Message-ID: <nycvar.YSQ.7.76.1803141148570.28583@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull the following:

  git://git.linaro.org/people/nicolas.pitre/linux lds

This series posted last week continues on the linker script cleanups 
that were started in commit 0d302c710b ("ARM: vmlinux-xip.lds.S: fix 
multiple issues"). Many duplications between the XIP and non-XIP scripts 
are factored out in a common file, and the TCM support with an XIP 
kernel is now possible.

This makes for a nice diffstat:

 arch/arm/kernel/vmlinux-xip.lds.S | 166 ++----------------------------
 arch/arm/kernel/vmlinux.lds.S     | 172 ++------------------------------
 arch/arm/kernel/vmlinux.lds.h     | 135 +++++++++++++++++++++++++
 arch/arm/mm/init.c                |  11 --
 4 files changed, 156 insertions(+), 328 deletions(-)

Thanks.


Nicolas
