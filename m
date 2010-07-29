From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Thu, 29 Jul 2010 09:04:07 -0700
Subject: ARM: LPC32xx: Misc arch updates and fixes
Message-ID: <1280419454-1089-1-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes several small issues with the LPC32xx Linux
support:
	LPC definition fixes
	Remove un-needed code from IRQ ack handler
	Fix GPIO 3 IN bit mask
	Change AMBA pre and post clock init for AMBA registration
	Add a workaround for LCD register access prior to clock enable
	Remove un-needed local MMC clock enable code
	Fix up I2S device ID name for clock registration

The LPC32xx will thrown an ARM exception if an attempt is made to access a
peripheral register set without the clocks enabled. Patch 5 (workaround for
LCD register access) is needed to work around an issue with the LCD driver.
During the AMBA PL11x driver init, an access is made to the peripheral
registers while the clock is disabled. This workaround prevents an exception
during init.

The series can be pulled from:
	git://git.lpclinux.com/linux-2.6-lpc wells/lpc32xx-arch_up1
