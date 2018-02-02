From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 02 Feb 2018 22:47:23 +0100
Subject: [PATCH v3] arm64: dts: rockchip: add roc-rk3328-cc board
In-Reply-To: <20180123021017.24110-1-djw@t-chip.com.cn>
References: <20180106094538.15568-1-djw@t-chip.com.cn>
 <20180123021017.24110-1-djw@t-chip.com.cn>
Message-ID: <3332426.dR0IG2DWyn@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Levin,

Am Dienstag, 23. Januar 2018, 03:10:17 CET schrieb djw at t-chip.com.cn:
> From: Levin Du <djw@t-chip.com.cn>
> 
> Hi all,
> 
> v3:
> Use pmic at 18 instead of rk805 at 18
> Use macro definition RK_Pxx in gpio number
> 
> v2:
> Use SPDX license tag
> 
> Thanks.
> 
> The roc-rk3328-cc is a credit card size single board computer using the
> Rockchip RK3328 Quad-Core ARM Cortex A53 64-Bit Processor and supporting
> up to 2GB 2133MHz LPDDR4 memory. It provides eMMC module socket, MicroSD
> Card slot, USB 2.0/3.0, Gigabit Ethernet, HDMI/CVBS, Infrared Receiver,
> SPDIF/I2S, and SPI/I2C/UART/PWM interfaces.
> 
> The devicetree currently supports basic peripherals.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>

I've applied the patch for 4.17 with some changes:
- dropped the version prose in the commit message as noted by Rob
- dropped the usbdrd3 elements for the time being.
  Definitly not your fault and I did pick up the core usb3 enablement
  for the rk3328, but it looks like this needs a bit more time as the phy
  has this issue of not recognizing device unpluggs, making the controller
  not taking any plug events after that at all.
  So I want to make that actually work, before I bind myself to the binding
  using the dwc3-of-simple stuff.
  We can readd the dwc3 nodes to the roc-3328-cc once that works correctly.

Heiko
