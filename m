From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 1 Feb 2015 10:47:02 +0100
Subject: bq2415x_charger.c: battery is discharged (fast, 224mA) when it
 should be charged
Message-ID: <20150201094702.GA21628@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I connected N900 with full battery using USB. For some reason, charge
limit was set to 100mA, battery was "full" and was discharging:

root at n900:/my/tui/ofone# ./tefone
Ready.
Battery  4.017 V  4.039 V  81 %  0 %  0 / 0 / 2056 mAh  Full -242.224 / 550 / 100  mA

I adjusted the current limit, but got no change, battery is still
discharging, fast:

root at n900:/my/tui/ofone# echo 500 > /sys/class/power_supply/bq24150a-0/current_limit
root at n900:/my/tui/ofone# ./tefone
Ready.
Battery  3.994 V  4.034 V  78 %  0 %  0 / 0 / 2056 mAh  Full   -251.506 / 550 / 500  mA
Battery  4.0 V  4.037 V  79 %  0 %  0 / 0 / 2056 mAh  Full   -223.125 / 550 / 500  mA
Battery  4.005 V  4.037 V  79 %  0 %  0 / 0 / 2056 mAh  Full   -224.91 / 550 / 500  mA
Battery  3.994 V  4.037 V  78 %  0 %  0 / 0 / 2056 mAh  Full   -224.91 / 550 / 500  mA
Battery  4.023 V  4.037 V  81 %  0 %  0 / 0 / 2056 mAh  Full   -224.91 / 550 / 500  mA
Battery  4.011 V  4.037 V  80 %  0 %  0 / 0 / 2056 mAh  Full   -224.91 / 550 / 500  mA
Battery  3.994 V  4.031 V  78 %  0 %  0 / 0 / 2056 mAh  Full   -256.504 / 550 / 500  mA
Battery  3.994 V  4.029 V  78 %  0 %  0 / 0 / 2056 mAh  Full   -224.017 / 550 / 500  mA
Battery  3.988 V  4.029 V  77 %  0 %  0 / 0 / 2056 mAh  Full   -224.731 / 550 / 500  mA
Battery  4.005 V  4.023 V  79 %  0 %  0 / 0 / 2056 mAh  Full   -223.66 / 550 / 500  mA

I'm getting a lot of

[  208.037719] bq27x00-battery 2-0055: battery is not calibrated! ignoring capacity values
[  238.038024] bq27x00-battery 2-0055: battery is not calibrated! ignoring capacity values

messages, that's why all the 0s in battery information dump.

Any ideas?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
