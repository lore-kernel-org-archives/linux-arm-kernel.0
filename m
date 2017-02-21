From: dawei.chien@mediatek.com (Dawei Chien)
Date: Tue, 21 Feb 2017 20:26:51 +0800
Subject: [PATCH v2 0/1] thermal: mt8173: minor mtk_thermal.c cleanups
Message-ID: <1487680012-61948-1-git-send-email-dawei.chien@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If thermal bank with 4 sensors, thermal driver should read TEMP_MSR3.

However, currently thermal driver would not read TEMP_MSR3 since mt8173
thermal driver only use 3 sensors on each thermal bank at the same time,
so this patch would not effect temperature.
Only if mt mt8173 thermal driver use 4 sensors on any thermal bank, would
read third sensor two times, and lose fourth sensor of vale.

Change since V1:
1. Update commis message
 a. Add Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
 b. Add tag Fixes: b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")
