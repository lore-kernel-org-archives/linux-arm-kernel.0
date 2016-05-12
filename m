From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 11 May 2016 18:02:25 -0700
Subject: [PATCH 0/3] msm_serial cleanups
Message-ID: <20160512010228.21548-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a small set of three patches that mostly gets rid
of the header file and protects us from a bad uartclk setting
if the stars align improperly (so far they haven't). I also
cleaned up the includes to protect us from any include
update fallout.

Stephen Boyd (3):
  tty: serial: msm: Move header file into driver
  tty: serial: msm: Only configure MND registers on hw that has it
  tty: serial: msm: Cleanup include usage

 drivers/tty/serial/msm_serial.c | 189 +++++++++++++++++++++++++++++++++++++---
 drivers/tty/serial/msm_serial.h | 184 --------------------------------------
 2 files changed, 179 insertions(+), 194 deletions(-)
 delete mode 100644 drivers/tty/serial/msm_serial.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
