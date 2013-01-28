From: monstr@monstr.eu (Michal Simek)
Date: Mon, 28 Jan 2013 13:53:11 +0100
Subject: [GIT PULL v3] arm-soc: Xilinx zynq timer changes for v3.9
In-Reply-To: <CAHTX3d+qeKPT3YYG3=YgWYN5YTS1oT9HoTEpVwC4GZAYve5uYw@mail.gmail.com>
References: <CAHTX3d+qeKPT3YYG3=YgWYN5YTS1oT9HoTEpVwC4GZAYve5uYw@mail.gmail.com>
Message-ID: <CAHTX3d+tDZF1-aKKfx+Zsb4FefrBbLaxe9qAz1Vsf3rDb-qHTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

based on your previous email I am sending updated pull request which is based
on arm-soc depends/cleanup branch.
As I wrote in my email I tend to keep there Soren's patch around
renaming PSS to PS
and be more strict on this for future.
I have also added one more patch which fix Rob's conversion to irqchip_init.

btw: As I mentioned in the previous email I want to add 2 defconfig
updates + maintainer
fragment. I have created branch zynq/misc in the same repo. Is this
name ok for you?
If yes, I will send you separate pull request just for this branch.

Thanks,
Michal

The following changes since commit f8060f5446b1f2782f0a8ca9be2d870ea4198aee:
  Olof Johansson (1):
        Merge tag 'gic-vic-to-irqchip' of
git://sources.calxeda.com/kernel/linux into next/cleanup

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git zynq/timer

Michal Simek (1):
      arm: zynq: Add missing irqchip.h to common.c

Soren Brinkmann (7):
      arm: zynq: timer: Replace PSS through PS
      arm: zynq: timer: Remove unnecessary register write
      arm: zynq: timer: Remove unused #defines
      arm: zynq: timer: Align columns
      arm: zynq: timer: Remove redundant #includes
      arm: zynq: timer: Fix comment style
      arm: zynq: timer: Set clock_event cpumask

 arch/arm/mach-zynq/common.c |    3 +-
 arch/arm/mach-zynq/common.h |    2 +-
 arch/arm/mach-zynq/timer.c  |  150 ++++++++++++++++++++----------------------
 3 files changed, 74 insertions(+), 81 deletions(-)

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
