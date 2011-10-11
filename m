From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 11 Oct 2011 19:03:37 +0800
Subject: [PATCH v4 0/3] add Atmel ISI, ov2640 support for sam9m10/sam9g45
Message-ID: <1318331020-22031-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all

Accroding to the comments from Guennadi, please see below the changes since V3:
1. Move isi_mck registration to at91_add_device_isi, but the user has a chance to or not to use the Programmable clock of the SoC.
2. In board file, e.g. board-sam9m10g45ek.c, user can pass a boolean to at91_add_device_isi, so that the SoC programmable clock can be used or not.

To summary, programmable clock is managed in SoC level. The user can decide to use or not to use SoC clock as the sensor MCK at board level. 
In later case, user has to provide a clock source named "isi_mck"

Best Regards,
Josh Wu
