From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 08 Mar 2018 17:38:42 +0100
Subject: [PATCH v9 3/5] drm/rockchip: inno_hdmi: reorder
 clk_disable_unprepare call in unbind
In-Reply-To: <20180302175757.28192-4-enric.balletbo@collabora.com>
References: <20180302175757.28192-1-enric.balletbo@collabora.com>
 <20180302175757.28192-4-enric.balletbo@collabora.com>
Message-ID: <7281273.So3vQhM8Nz@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 2. M?rz 2018, 18:57:55 CET schrieb Enric Balletbo i Serra:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> In bind the clk_prepare_enable of the HDMI pclk is called before adding the
> i2c_adapter. So it should be the other way around in unbind, first remove
> the i2c_adapter and then call the clk_disable_unprepare.
> 
> Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied to drm-misc-next

Thanks
Heiko
