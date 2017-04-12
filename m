From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 12 Apr 2017 15:29:24 +0200
Subject: [PATCH v3] arm64: dts: rk3399: add support for firefly-rk3399
 board
In-Reply-To: <1491796213-4115-1-git-send-email-kever.yang@rock-chips.com>
References: <1491796213-4115-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1642127.PiTFsmK4zh@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kever,

Am Montag, 10. April 2017, 11:50:13 CEST schrieb Kever Yang:
> Firefly-rk3399 is a bord from T-Firefly, you can find detail about
> it here:
> http://en.t-firefly.com/en/firenow/Firefly_RK3399/
> 
> This patch add basic node for the board and make it able to bring
> up.
> 
> Peripheral works:
> - usb hub which connect to ehci controller;
> - UART2 debug
> - eMMC
> - PCIe
> 
> Not work:
> - USB 3.0 HOST, type-C port
> - sdio, sd-card
> 
> Not test for other peripheral:
> - HDMI
> - Ethernet
> - OPTICAL
> - WiFi/BT
> - MIPI CSI/DSI
> - IR
> - EDP/DP
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

applied for 4.13, as we're a bit late for 4.12, with the following changes:
- commit subject
- dropped status from backlight (as there is no disabled common node
  and it's specific to the firefly itself)
- quite some reordering of properties
- reordered regulator nodes per their addresses: 0x1b < 0x40
- dropped obsolete regulator-compatible properties
- fixed gpio-irq on the mpu6500
- dropped out-of-tree orientation properties of mpu6500
  --> please provide the optional "mount-matrix" in a follow-up patch
      see bindings/iio/imu/inv_mpu6050.txt
- dropped rockchip,i2s-broken-burst-len;
  That change never made it into the mainline kernel
- fixed pcie pinctrl indentation
- dropped wireless-bluetooth uart-gpios pinctrl
- dropped supports-emmc property

Please try to be a bit more careful when porting stuff from device kernels
with respect to properties not found in the mainline kernel and please
also double-check in [0] that I didn't break anything.


Thanks
Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=495a3c891a696b62465d71b1a125e3424352028b
