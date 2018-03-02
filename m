From: klaus.goger@theobroma-systems.com (klaus.goger at theobroma-systems.com)
Date: Fri, 2 Mar 2018 20:49:51 +0100
Subject: [PATCH v2 6/6] arm64: dts: rockchip: enable typec-phy0 for
 rk3399-puma-haikou.
In-Reply-To: <20180301152515.20940-7-enric.balletbo@collabora.com>
References: <20180301152515.20940-1-enric.balletbo@collabora.com>
 <20180301152515.20940-7-enric.balletbo@collabora.com>
Message-ID: <FF2D7ADA-3524-4811-921D-3AC6ABA2E588@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 01.03.2018, at 16:25, Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
> 
> Commit c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port
> support for rk3399") caused a regression regarding the USB3. During
> boot, the following message appears a few times:
> 
>    dwc3: failed to initialize core
> 
> The driver is deferred waiting for the typec-phy, but this never
> happens beause is disabled. So, enable it.
> 
> Fixes: c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port support for rk3399")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2: None
> 
> arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
> index 9a7486058455..2c9c696d1383 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
> @@ -191,6 +191,10 @@
> 	status = "okay";
> };
> 
> +&tcphy0 {
> +	status = "okay";
> +};
> +
> &u2phy0 {
> 	status = "okay";
> };
> -- 
> 2.16.1


Tested-by: Klaus Goger <klaus.goger@theobroma-systems.com>

With usbdrd_dwc3_0 changed to dr_mode = "host"

[   37.176540] usb 6-1: new SuperSpeed USB device number 2 using xhci-hcd
[   37.203962] usb-storage 6-1:1.0: USB Mass Storage device detected
[   37.211837] scsi host1: usb-storage 6-1:1.0
[   38.249378] scsi 1:0:0:0: Direct-Access     SanDisk  Ultra            1.00 PQ: 0 ANSI: 6
[   38.259097] sd 1:0:0:0: [sdb] 122421248 512-byte logical blocks: (62.7 GB/58.4 GiB)
[   38.268890] sd 1:0:0:0: [sdb] Write Protect is off
[   38.274269] sd 1:0:0:0: [sdb] Mode Sense: 43 00 00 00
[   38.274582] sd 1:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   38.295967]  sdb: sdb1
[   38.300787] sd 1:0:0:0: [sdb] Attached SCSI removable disk
< detaching>
[   45.192248] usb 6-1: USB disconnect, device number 2

? 
Klaus
