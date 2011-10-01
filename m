From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 1 Oct 2011 10:32:58 +0800
Subject: [GIT PULL] ARM: CSR: l2x0 init cleanup for 3.2
Message-ID: <CAGsJ_4xNqgDSWs-WQCamE592NB_p4r4+sY8-XSrzbkei1jeB7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Since the l2x0 cleanup of prima2 depends on the following two patches
in rmk's tree:

[1]Rob Herring
ARM: 7009/1: l2x0: Add OF based initialization
http://www.spinics.net/lists/arm-kernel/msg131123.html
it has been in rmk/for-next

[2]Barry Song
ARM: 7009/1: CACHE-L2X0: filter start address can be 0 and is often 0
http://www.spinics.net/lists/arm-kernel/msg140126.html
it has been in rmk/for-next

I have rebased the l2x0-cleanup branch to "ARM: 7009/1: CACHE-L2X0:
filter start address can be 0 and is often 0". this might cause some
issues to you. if that is difficult to you, i guess you can pich the
commmit and apply it when your tree has been ready.

The following changes since commit 513d47a3d953e44d79c29077f6c428a017f8af62:
  Barry Song (1):
        ARM: 7090/1: CACHE-L2X0: filter start address can be 0 and is often 0

are available in the git repository at:

  git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git l2x0-cleanup

Barry Song (1):
      ARM: CSR: call l2x0_of_init to init L2 cache of SiRFprimaII

 arch/arm/boot/dts/prima2-cb.dts |    5 +++-
 arch/arm/mach-prima2/l2x0.c     |   46 +++++++-------------------------------
 2 files changed, 13 insertions(+), 38 deletions(-)


Thanks
barry
