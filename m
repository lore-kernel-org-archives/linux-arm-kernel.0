From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 09 Jan 2016 20:33:51 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Change RTC_DRV_HYM8563 to builtin
In-Reply-To: <1452367683-11160-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1452367683-11160-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <4578616.QcQm44RoCq@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 9. Januar 2016, 20:28:02 schrieb Sjoerd Simons:
> Apart from providing an RTC the hym8563 chip on some rockchip boards
> (e.g. rock2 square and firefly) also provide the 32khz clock used by the
> SoCs thermal sensors.
> 
> Switch the driver from a module to builtin such that the thermal
> protection can work even if modules aren't used/loaded.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Personally I'm ok with the reasoning for requiring rtc to be build in,
but I guess others might disagree. Nevertheless

Acked-by: Heiko Stuebner <heiko@sntech.de>

and we'll let armsoc-people decide ;-) .


Ideally we would do the same for the rk808 rtc as well - as it is exactly 
the same argument / case.


Heiko
