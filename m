From: davidb@codeaurora.org (David Brown)
Date: Fri, 03 Jun 2011 17:15:45 -0700
Subject: [PATCH v2 0/7] Move Qualcomm gpio drivers into drivers dir
In-Reply-To: <1307141059-22431-1-git-send-email-davidb@codeaurora.org> (David
	Brown's message of "Fri, 3 Jun 2011 15:44:12 -0700")
References: <1305755453-31112-1-git-send-email-davidb@codeaurora.org>
	<1307141059-22431-1-git-send-email-davidb@codeaurora.org>
Message-ID: <8yavcwmsb7y.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03 2011, David Brown wrote:

> This patch series moves the Qualcomm MSM gpio device drivers into the
> drivers/gpio directory.

Grant, feel free to pull these changes from my git repo if you'd like.
(assuming there are no additional objections to the change).

Thanks,
David

The following changes since commit 55922c9d1b84b89cb946c777fddccb3247e7df2c:

  Linux 3.0-rc1 (2011-05-29 17:43:36 -0700)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/davidb/linux-msm.git msm-move-gpio

David Brown (7):
      msm: gpio: Remove unsupported devices
      msm: Remove chip-ifdefs for GPIO io mappings
      msm: gpio: Remove chip-specific register definitions
      msm: gpio: Remove ifdefs on gpio chip registers
      msm: gpiomux: Move public API to public header
      gpio_msm: Move Qualcomm v6 MSM driver into drivers
      gpio_msm: Move Qualcomm MSM v2 gpio driver into drivers

 arch/arm/mach-msm/Kconfig                          |    4 +
 arch/arm/mach-msm/Makefile                         |    8 -
 arch/arm/mach-msm/gpio_hw.h                        |  278 --------------------
 arch/arm/mach-msm/gpiomux.h                        |   17 +--
 arch/arm/mach-msm/include/mach/msm_gpiomux.h       |   38 +++
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h    |   10 +-
 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h    |   10 +-
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h    |   10 +-
 arch/arm/mach-msm/include/mach/msm_iomap.h         |    2 +
 arch/arm/mach-msm/io.c                             |   12 +-
 drivers/gpio/Kconfig                               |   16 ++
 drivers/gpio/Makefile                              |    2 +
 arch/arm/mach-msm/gpio.c => drivers/gpio/msm_v1.c  |  111 +++++----
 drivers/gpio/msm_v1.h                              |  271 +++++++++++++++++++
 .../mach-msm/gpio-v2.c => drivers/gpio/msm_v2.c    |    2 +-
 15 files changed, 414 insertions(+), 377 deletions(-)
 delete mode 100644 arch/arm/mach-msm/gpio_hw.h
 create mode 100644 arch/arm/mach-msm/include/mach/msm_gpiomux.h
 rename arch/arm/mach-msm/gpio.c => drivers/gpio/msm_v1.c (82%)
 create mode 100644 drivers/gpio/msm_v1.h
 rename arch/arm/mach-msm/gpio-v2.c => drivers/gpio/msm_v2.c (99%)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
