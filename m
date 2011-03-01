From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 10:03:20 +0530
Subject: [RFC] device.h: add device_set_platdata routine
Message-ID: <5c561db378360ad1763da41f8350c7be816daa06.1298953633.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

device.h supports device_get_platdata but doesn't support device_set_platdata.
This routine is required by platforms in which device structure is declared
in a machine specific file and platform data comes from board specific file.

This will be used by SPEAr patches sent in separate patch series.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 include/linux/device.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 1bf5cf0..6ce0f20 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -576,6 +576,11 @@ static inline void *dev_get_platdata(const struct device *dev)
 	return dev->platform_data;
 }
 
+static inline void dev_set_platdata(struct device *dev, void *platdata)
+{
+	dev->platform_data = platdata;
+}
+
 /*
  * Manual binding of a device to driver. See drivers/base/bus.c
  * for information on use.
-- 
1.7.2.2
