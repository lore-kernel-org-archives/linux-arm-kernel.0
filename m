From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 18 Aug 2017 11:18:24 +0200
Subject: [PATCH] arm64: dts: rockchip: disable tx ipgap linecheck for
 rk3399 dwc3
In-Reply-To: <1502958272-1384-1-git-send-email-william.wu@rock-chips.com>
References: <1502958272-1384-1-git-send-email-william.wu@rock-chips.com>
Message-ID: <4718044.sxV3Y2WdLf@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 17. August 2017, 16:24:32 CEST schrieb William Wu:
> RK3399 USB DWC3 controller has a issue that FS/LS devices not
> recognized if inserted through USB 3.0 HUB. It's because that
> the inter-packet delay between the SSPLIT token to SETUP token
> is about 566ns, more then the USB spec requirement.
> 
> This patch adds a quirk "snps,dis-tx-ipgap-linecheck-quirk" to
> disable the u2mac linestate check to decrease the SSPLIT token
> to SETUP token inter-packet delay from 566ns to 466ns.
> 
> Signed-off-by: William Wu <william.wu@rock-chips.com>

applied for 4.14


Thanks
Heiko
