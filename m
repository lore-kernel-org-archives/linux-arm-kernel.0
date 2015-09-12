From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 12 Sep 2015 13:00:45 -0700
Subject: [PATCH 5/7] soc: brcmstb: add wake-timer driver
In-Reply-To: <1434672696-13632-6-git-send-email-computersforpeace@gmail.com>
References: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
 <1434672696-13632-6-git-send-email-computersforpeace@gmail.com>
Message-ID: <55F4846D.5040304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 06/18/15 17:11, Brian Norris a ?crit :
> Useful for waking the system from suspend after a specified period of
> time.
> 
> This IP could potentially be supported as an RTC driver (for use with
> the 'rtcwake' utility), but it is not battery backed, so that's not a
> great fit. Implement a custom sysfs interface instead.

I would very much like to see this driver be implemented as a degenerate
RTC driver because this sorts of maps pretty well to the "rtcwake" use
mode, and this is a persistent clock source, and even a clock source as
well (I would rather avoid going the MFD route to expose these 3
"functions" though).

Thanks!
-- 
Florian
