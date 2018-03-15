From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Thu, 15 Mar 2018 10:29:47 +0100
Subject: [PATCH 0/2] cec: stm32: add wakeup support
Message-ID: <20180315092949.9895-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CEC hardware block is enable to resume the system if a command is received
on data lane.
Prior to implement suspend/resume functions a patch simplify clock management
int the driver by introducting pm_runtime{suspend/resume} functions.

Benjamin Gaignard (2):
  cec: stm32: simplify clock management
  cec: stm32: add suspend/resume functions

 drivers/media/platform/stm32/stm32-cec.c | 112 ++++++++++++++++++++++---------
 1 file changed, 82 insertions(+), 30 deletions(-)

-- 
2.15.0
