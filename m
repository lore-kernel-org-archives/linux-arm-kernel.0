From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 10 Jul 2010 19:57:46 +0300
Subject: [PATCH v2 0/3] s3c24xx: iPAQ rx1950 series
Message-ID: <1278781069-30521-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds more support for iPAQ rx1950 PDA to linux:
1. LEDs driver -- it controls blue, green and red LEDs on rx1950
2. Battery driver -- adds ability to monitor and charge battery.
This driver is suitable for H1940 PDA aswell (just need to write
some machine specific callbacks and get voltage LUTs)

v2: removed ac registration from s3c_adc_battery driver, use
pda_power instead for ac support.

P.S. I prefer to keep own LED triggers for s3c_adc_battery as
generic power supply triggers do not support LED_HALF brightness
(on h1940/rx1950 it's used for blink) and I want to keep same
LEDs behavior as in WinMo.
