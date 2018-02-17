From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 17 Feb 2018 01:08:07 +0100
Subject: [PATCH v3 3/6] phy: rockchip-typec: enable usb3 host during usb3
 phy power on
In-Reply-To: <20180216120956.19034-3-enric.balletbo@collabora.com>
References: <20180216120956.19034-1-enric.balletbo@collabora.com>
 <20180216120956.19034-3-enric.balletbo@collabora.com>
Message-ID: <3430653.U8tW0J7X0D@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 16. Februar 2018, 13:09:53 CET schrieb Enric Balletbo i Serra:
> From: William wu <wulf@rock-chips.com>
> 
> We have forced usb3 to work in usb2 only mode in firmware by setting
> usb3tousb2_en (bit3 of GRF_USB3PHY0/1_CON0) to 1, and setting
> host_u3_port_disable (bit0 of GRF_USB3OTG0/1_CON1) to 1 and host_u3_port
> (bit15~12 of GRF_USB3OTG0/1_CON1) to 0. So we need to re-enable usb3
> host.
> 
> Note that the RK3399 TRM suggests that we should keep the whole usb3
> controller in reset for the duration of the Type-C PHY initialization.
> However, it's hard to assert the reset in the current framework of
> reset. And according to the TRM, it doesn't require that we should
> clear the usb3tousb2 bit before pipe ready. So let's enable the usb3
> host after pipe ready to avoid the Type-C PHY initialization failure.
> 
> Signed-off-by: William wu <wulf@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
