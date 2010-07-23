From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 23 Jul 2010 18:21:15 +0200
Subject: [PATCH v3 0/8] Samsung S5P SoC camera interface driver
Message-ID: <1279902083-21250-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a third version of my patch series adding support for camera interface,
video output and video processing IP contained in Samsung's S3C/S5P SoCs.

Changes since v1:
- support for multiple SoC variants through the platform device name overriding
  (S5PC100 and SPV210 version definitions included)

Changes since v2:
- reworked register definition, minor synchronization fixes, whitespace cleanup
- removed support for FIFO mode output to the lcd controller due to
  hardware limitations (removed fifo link and platform data setup code
  and v4l2_subdevice in s3c-fb driver)


The following patch series contains:

[PATCH v3 1/8] ARM: Samsung: Add register definitions for Samsung S5P SoC camera interface
[PATCH v3 2/8] v4l: Add driver for Samsung S3C/S5P SoC video postprocessor
[PATCH v3 3/8] ARM: Samsung: Add platform definitions and helpers for FIMC driver
[PATCH v3 4/8] ARM: Samsung: Add common Aquila and GONI code
[PATCH v3 5/8] ARM: s5pv210: enable FIMC on Aquila
[PATCH v3 6/8] ARM: s5pv210: enable FIMC on Goni
[PATCH v3 7/8] ARM: S5PC100: enable FIMC on SMDKC100
[PATCH v3 8/8] ARM: s5pv210: Override FIMC driver name on Aquila board


Best regards,
--
Sylwester Nawrocki
Linux Platform Group
Samsung Poland R&D Center
