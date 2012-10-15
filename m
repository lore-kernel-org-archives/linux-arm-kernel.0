From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 15 Oct 2012 17:30:26 +0800
Subject: [PATCH v3 0/2] i2c: change id to let i2c-gpio work
Message-ID: <1350293428-24551-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c core driver will turn the platform device ID to busnum
When using platfrom device ID as -1, it means dynamically assigned
the busnum. When writing code, we need to make sure the busnum,
and call i2c_register_board_info(int busnum, ...) to register device
if using -1, we do not know the value of busnum
	
In order to solve this issue, set the platform device ID as a fix number
Here using 0 to match the busnum used in i2c_regsiter_board_info()

Bo Shen (2):
  i2c: change id to let i2c-gpio work
  i2c: change id to let i2c-at91 work

 arch/arm/mach-at91/at91rm9200.c          |    2 +-
 arch/arm/mach-at91/at91rm9200_devices.c  |    4 ++--
 arch/arm/mach-at91/at91sam9260.c         |    4 ++--
 arch/arm/mach-at91/at91sam9260_devices.c |    4 ++--
 arch/arm/mach-at91/at91sam9261.c         |    4 ++--
 arch/arm/mach-at91/at91sam9261_devices.c |    4 ++--
 arch/arm/mach-at91/at91sam9263.c         |    2 +-
 arch/arm/mach-at91/at91sam9263_devices.c |    4 ++--
 arch/arm/mach-at91/at91sam9rl_devices.c  |    4 ++--
 9 files changed, 16 insertions(+), 16 deletions(-)

-- 
1.7.9.5
