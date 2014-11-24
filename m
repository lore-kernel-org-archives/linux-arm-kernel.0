From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 24 Nov 2014 23:50 +0100
Subject: [PATCH v8 0/4] This is the 1st version of suspend for RK3288.
In-Reply-To: <1416051910-16730-1-git-send-email-zyw@rock-chips.com>
References: <1416051910-16730-1-git-send-email-zyw@rock-chips.com>
Message-ID: <2829328.asIzdRTr9b@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

Am Samstag, 15. November 2014, 19:45:06 schrieb Chris Zhong:
> This suspend patch is only support cut off the power of cpu and some
> external devices, since we still lack power_domain driver, so the other
> power rail of rk3288 need keep power on.
> I have tested it on rk3288-evb board, atop next-20141112. goto suspend by
> type "echo mem > /sys/power/state", vdd_cpu is about 0mv by measuring, so
> it can be determined in sleep mode, then press power button to wakeup it.

with this version my board can finally wake up again. Although it wakes 
immediatly again. But as it wakes at all, I'm quite happy :-) .

I remember this being mentioned before, but I don't remember what was 
responsible for that. Was it because we only enter the light suspend mode 
instead of the deep one or some interrupt somewhere?


I've been running on top of linux-next from 20141124 with the following 
patches applied on top of your v8 series:

pinctrl: rockchip: Fix enable/disable/mask/unmask
pinctrl: rockchip: Handle wakeup pins
serial: 8250_dw: Handle no_console_suspend when uart loses state


Heiko
