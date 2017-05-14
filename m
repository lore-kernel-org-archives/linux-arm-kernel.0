From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 14 May 2017 16:59:17 +0200
Subject: [PATCH] ARM: dts: rockchip: add missing grf phandle for rk3288
In-Reply-To: <20170507143446.11502-1-ayaka@soulik.info>
References: <20170507143446.11502-1-ayaka@soulik.info>
Message-ID: <53387334.ADQf94xZqP@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy,

Am Sonntag, 7. Mai 2017, 22:34:46 CEST schrieb Randy Li:
> The PWM devices need to access the grf to switch the PWM IP.

The grf property is not part of the pwm binding and I remember
this coming up in veyron times, when Thiery didn't want such settings
in the pwm driver. So the kernel pwm driver does not switch anything
right now.


> And tsadc uses it to shutdown the system.

No it doesn't. The tsadc on rk3288 does not do any grf settings right now,
as it is using the v2_initialize function. Only rk3366 and rk3399 seem
to do any grf settings in the current v4.12-rc1 . Or is there some tsadc
patch from you pending to change that?


Heiko
