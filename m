From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Jul 2013 11:37:27 -0700
Subject: [PATCH 0/4] msm_serial fixes and improvements
Message-ID: <1374691051-28544-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are a couple fixes and improvements to the msm_serial
driver. The first two patches fix a bug on UARTDM devices and
silence sparse warnings. The last two patches improve the baud
code detection and increase the throughput on UARTDM devices.

After this it is rather trivial to add support for newer UARTDM
devices via new compatible fields.

Stephen Boyd (4):
  msm_serial: Fix NUL byte output on UARTDM
  msm_serial: Fix sparse warnings
  msm_serial: Make baud_code detection more dynamic
  msm_serial: Send more than 1 character at a time on UARTDM

 drivers/tty/serial/msm_serial.c | 180 ++++++++++++++++++++--------------------
 drivers/tty/serial/msm_serial.h |  19 ++---
 2 files changed, 97 insertions(+), 102 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
