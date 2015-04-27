From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 28 Apr 2015 02:55:37 +0300
Subject: [PATCH v2 00/17] new locomo driver set
Message-ID: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sharp Zaurus SL-5500 and SL-5600 use special companion Gate Array.
With this patchset I tried to modernise and restructure the LoCoMo drivers.

* Use platform bus and mfd core code
* Use GPIO API instead of custom locomo GPIO code
* Use irqdomains to manage IRQs
* Split mixed locomolcd driver to lcd and backlight parts
* Implement IRQ handling in GPIO driver
* Implement SPI driver used as a host for mmc_spi device to control SD cards

V1 was submitted about a half of a year ago. Major changes:
* Use gpiod_* in most of places
* Use regmap for accessing registers instead of manual RMW cycles
* Split dac driver from core module to i2c bus and separate IIO driver
* Replaced mdelay() calls with usleep_range or msleep where it was suitable
* Rewrote SPI driver to use core transfer_one() interface
