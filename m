From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 04 Jul 2014 15:52:14 +0200
Subject: [PATCH 2/8] cpufreq: add driver for Armada XP
In-Reply-To: <20140704131247.2c8ecde2@free-electrons.com>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
 <20140704131247.2c8ecde2@free-electrons.com>
Message-ID: <1404481934.4634.2.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 04.07.2014, 13:12 +0200 schrieb Thomas Petazzoni:
[...]
> This doesn't work very well with the idea of having the OPP table
> statically encoded in to the Device Tree. Options are:
> 
>  - Improve the cpufreq-cpu0 driver so that the OPP table can be passed
>    through platform_data, and therefore built dynamically by the
>    platform code and passed when registering the cpufreq
>    platform_device.
> 
>  - Dynamically build/update the OPP table in the Device Tree.

This sounds like the right thing to do. Ideally your bootloader would do
this for you, so you don't have to encode those properties statically at
all.

Barebox already has facilities to fixup any loaded device tree. Have a
look at of_register_fixup() there.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
