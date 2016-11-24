From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 24 Nov 2016 13:01:31 +0100
Subject: [PATCH 1/9] clocksource/drivers/rockchip_timer: split bc_timer
 into rk_timer and rk_clock_event_device
In-Reply-To: <1479922177-20136-1-git-send-email-al.kochet@gmail.com>
References: <1479922177-20136-1-git-send-email-al.kochet@gmail.com>
Message-ID: <47746094.VbGlCfGZW0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

I haven't looked to deep into your patches yet, but what is missing is the 
general goal of your whole series.

git format-patch has this nice "--cover-letter" option that creates obviously 
a cover-letter where you can describe what your series wants to achieve.

For those reading along, I guess what you want to achieve should be what I 
describe below, so of course no need to resend just for this :-)

-----
The clock supplying the arm-global-timer on the rk3188 is coming from the
the cpu clock itself and thus changes its rate everytime cpufreq adjusts the 
cpu frequency making this timer unsuitable as a stable clocksource.

The rk3188, rk3288 and following socs share a separate timer block already 
handled by the rockchip-timer driver. Therefore adapt this driver to also be 
able to act as clocksource on rk3188.
-----

Right?


Heiko


Am Mittwoch, 23. November 2016, 20:29:29 schrieb Alexander Kochetkov:
> Move ce field out of struct bc_timer into struct rk_clock_event_device,
> rename struct bc_timer to struct rk_timer.
>
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
