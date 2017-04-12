From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 12 Apr 2017 11:03:00 -0500
Subject: [PATCH 8/8] arm64: defconfig: enable EDAC options
In-Reply-To: <1492012980-11650-1-git-send-email-timur@codeaurora.org>
References: <1492012980-11650-1-git-send-email-timur@codeaurora.org>
Message-ID: <1492012980-11650-9-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EDAC (Error Detection and Correction) and EDAC_MM_EDAC are required to
have EDAC_GHES enabled. EDAC_GHES support is needed to properly handle
memory errors from the APEI GHES framework as well as reporting these
types of errors to the user space via the memory controller trace event.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e99637a..5fd1409 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -420,6 +420,8 @@ CONFIG_LEDS_SYSCON=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+CONFIG_EDAC=y
+CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
