From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 27 Dec 2016 18:04:26 +0100
Subject: [RESEND PATCH v2] arm64: dts: rockchip: add u2phy clock for ehci
 and ohci of rk3399
In-Reply-To: <1482316865-2769-1-git-send-email-zhengxing@rock-chips.com>
References: <1482316182-2305-1-git-send-email-zhengxing@rock-chips.com>
 <1482316865-2769-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1731551.Q6cHK6n5ZM@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 21. Dezember 2016, 18:41:05 CET schrieb Xing Zheng:
> From: William wu <wulf@rock-chips.com>
> 
> We found that the suspend process was blocked when it run into
> ehci/ohci module due to clk-480m of usb2-phy was disabled.
> 
> The root cause is that usb2-phy suspended earlier than ehci/ohci
> (usb2-phy will be auto suspended if no devices plug-in). and the
> clk-480m provided by it was disabled if no module used. However,
> some suspend process related ehci/ohci are base on this clock,
> so we should refer it into ehci/ohci driver to prevent this case.
> 
> The u2phy clock flow like this:
> ===
>       u2phy ________________
> 
>            |                |    |-----> UTMI_CLK ---------> | EHCI |
> 
> OSC_24M ---|---> PHY_PLL----|----|
> 
>            |________^_______|    |-----> 480M_CLK ---|G|---> |
>            |USBPHY_480M_SRC| ----> USBPHY_480M for SoC
>                    GRF
> ===
> 
> Signed-off-by: William wu <wulf@rock-chips.com>
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

applied for 4.11 with Doug's Review-tag


Thanks
Heiko
