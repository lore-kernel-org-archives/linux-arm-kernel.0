From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 27 Dec 2014 20:24:31 +0100
Subject: [PATCH 2/3] hwmon: Driver for OMAP3 temperature sensor
In-Reply-To: <1419597294-21487-3-git-send-email-sre@kernel.org>
References: <20141226102933.GA28778@amd>
 <1419597294-21487-1-git-send-email-sre@kernel.org>
 <1419597294-21487-3-git-send-email-sre@kernel.org>
Message-ID: <20141227192431.GC10007@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!


> OMAP34xx and OMAP36xx processors contain a register in the syscon area,
> which can be used to determine the SoCs temperature. This patch provides
> a DT based driver for the temperature sensor based on an older driver
> written by Peter De Schrijver for the Nokia N900 and N9.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

I did clk_enable -> clk_prepare_enable conversion, as described in
another email.

I got occasional error reading:

root at n900:~# cat /sys/class/hwmon/hwmon0/device/temp_input
20.0
root at n900:~# cat /sys/class/hwmon/hwmon0/device/temp_input
cat: /sys/class/hwmon/hwmon0/device/temp_input: Input/output error
root at n900:~# cat /sys/class/hwmon/hwmon0/device/temp_input
20.0

Nothing in dmesg. It takes few tries to reproduce..

On other attempt, it hung hard:

root at n900:~# cat /sys/class/hwmon/hwmon0/device/temp_input ; cat
/sys/class/hwmon/hwmon0/device/temp_input  ;cat
/sys/class/hwmon/hwmon0/device/temp_input ; cat
/sys/class/hwmon/hwmon0/device/temp_input
17.0
17.0
^[[A



^Z


^C^C^C

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
