From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  5 Mar 2014 17:57:52 +0100
Subject: [PATCH 0/3] iio: adc: at91 fixes
Message-ID: <1394038675-15809-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes a kernel crash at probe time when using the at91_adc driver
through platform_data. This crash appeared in 3.13.

The first patch fixes the crash. While it is already quite late, I think it
would be good to get it in 3.14.

The next patches restore support for at91_adc on the at91sam9g45 and at91sam9260
based boards. It would be great if they could make it in 3.14. But I'm not sure
it is worth applying them to 3.13.

Alexandre Belloni (3):
  iio: adc: at91_adc: Repair broken platform_data support
  ARM: at91: at91sam9g45: change at91_adc name
  ARM: at91: at91sam9260: change at91_adc name

 arch/arm/mach-at91/at91sam9260_devices.c |  2 +-
 arch/arm/mach-at91/at91sam9g45_devices.c |  2 +-
 drivers/iio/adc/at91_adc.c               | 26 ++++++++++++++++++++++----
 3 files changed, 24 insertions(+), 6 deletions(-)

-- 
1.8.3.2
