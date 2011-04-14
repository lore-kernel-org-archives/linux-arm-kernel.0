From: inki.dae@samsung.com (daeinki)
Date: Thu, 14 Apr 2011 21:15:13 +0900
Subject: [PATCH 0/2] video: add Samsung SoC based MIPI-DSI support.
In-Reply-To: <4CE5D2BB.2060308@samsung.com>
References: <4CE5D2BB.2060308@samsung.com>
Message-ID: <4DA6E551.1060300@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, all.

Samsung S5PV210 and EXYNOS4 SoC platform have one or two MIPI-DSI
controller and MIPI-DSI based LCD Panel could be used with this one.
this patch adds Samsung SoC based MIPI-DSI support.

to use MIPI-DSI based LCD Panel driver, mipi_dsim_lcd_device shoule be
registered to MIPI-DSI driver through s5p_mipi_dsi_register_lcd_device()
at machine code or machine specific somewhere first, and
mipi_dsim_lcd_driver should be registered when
s5p_mipi_dsi_register_driver() is called at init function of lcd driver,
and then probe() of that driver would be called by MIPI-DSI controller
driver if lcd panel name and id of mipi_dsim_lcd_device are same as ones
of mipi_dsim_lcd_driver.

for this, you can refer to sample lcd panel driver.
please see "Documentation/s5p_mipi_dsim/dsim_sample_lcd.c"

this patch series includes the following.

[PATCH 1/2] video: add Samsung SoC MIPI-DSI controller driver.
[PATCH 2/2] video: add Samsung SoC MIPI-DSI based sample lcd panel driver.
