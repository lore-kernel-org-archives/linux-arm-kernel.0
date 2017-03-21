From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Tue, 21 Mar 2017 11:59:30 +0100
Subject: [PATCH 4/6] gpio: gemini: rename to match Faraday IP
In-Reply-To: <20170312232818.26304-4-linus.walleij@linaro.org>
References: <20170312232818.26304-1-linus.walleij@linaro.org>
 <20170312232818.26304-4-linus.walleij@linaro.org>
Message-ID: <CACmBeS2OC6X_Rb5qaVEGMY4mPyHwnib-=pm-g=+73J6ZSRDgLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Verified on UC-7112-LX by buzzing the buzzer and writing the RTC (see
log [1] for next-20170310):

[1] https://bitbucket.org/Kasreyn/linux-next/commits/c63f3c2215f6fd106ff0ec6f9864b85b7be565ac

[    0.000000] Linux version 4.11.0-rc1-next-20170310-00004-gc63f3c2
(i at ildjarn) (gcc version 4.9.1 (crosstool-NG 1.20.0) ) #4461 PREEMP
T Tue Mar 21 11:43:29 CET 2017
..
echo 24 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio24/direction
echo 1 > /sys/class/gpio/gpio24/value
echo 0 > /sys/class/gpio/gpio24/value
..
date +%Y%m%d%h%m -s "201001202323"
hwclock -w
reboot
..
[    4.520000] moxart-rtc 90000000.soc:rtc: setting system clock to
2010-01-20 23:23:20 UTC (1264029800)
..
date +%Y%m%d%h%m -s "201212181553"
hwclock -w
reboot
..
[    4.520000] moxart-rtc 90000000.soc:rtc: setting system clock to
2012-12-18 15:53:20 UTC (1355846000)


Tested-by: Jonas Jensen <jonas.jensen@gmail.com>
