From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 13 Apr 2017 10:22:28 +0200
Subject: [PATCH v3] arm64: dts: rk3399: add support for firefly-rk3399
 board
In-Reply-To: <6d1eb0cc-fe3b-a483-123c-8558096c0846@rock-chips.com>
References: <1491796213-4115-1-git-send-email-kever.yang@rock-chips.com>
 <1642127.PiTFsmK4zh@phil>
 <6d1eb0cc-fe3b-a483-123c-8558096c0846@rock-chips.com>
Message-ID: <11306035.2UDh49FpL9@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 13. April 2017, 12:00:19 CEST schrieb Kever Yang:
> Hi Heiko,
> 
> On 04/12/2017 09:29 PM, Heiko Stuebner wrote:
> > Hi Kever,
> > 
> > Am Montag, 10. April 2017, 11:50:13 CEST schrieb Kever Yang:
> >> Firefly-rk3399 is a bord from T-Firefly, you can find detail about
> >> it here:
> >> http://en.t-firefly.com/en/firenow/Firefly_RK3399/
> >> 
> >> This patch add basic node for the board and make it able to bring
> >> up.
> >> 
> >> Peripheral works:
> >> - usb hub which connect to ehci controller;
> >> - UART2 debug
> >> - eMMC
> >> - PCIe
> >> 
> >> Not work:
> >> - USB 3.0 HOST, type-C port
> >> - sdio, sd-card
> >> 
> >> Not test for other peripheral:
> >> - HDMI
> >> - Ethernet
> >> - OPTICAL
> >> - WiFi/BT
> >> - MIPI CSI/DSI
> >> - IR
> >> - EDP/DP
> >> 
> >> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > 
> > applied for 4.13, as we're a bit late for 4.12, with the following 
changes:
> Thanks for your help, I'm not familiar with the devices status on upstream
> because not working on kernel upstream for a long time.
> 
> > - commit subject
> > - dropped status from backlight (as there is no disabled common node
> > 
> >    and it's specific to the firefly itself)
> > 
> > - quite some reordering of properties
> > - reordered regulator nodes per their addresses: 0x1b < 0x40
> > - dropped obsolete regulator-compatible properties
> > - fixed gpio-irq on the mpu6500
> > - dropped out-of-tree orientation properties of mpu6500
> > 
> >    --> please provide the optional "mount-matrix" in a follow-up patch
> >    
> >        see bindings/iio/imu/inv_mpu6050.txt
> 
> Maybe we can drop this mpu6050 node first? I can't find binding file for it.

The binding (and driver in the kernel) is the same as for the mpu6050.
So you can find the documentation in
Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt

Someone should add the other ids from 
drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
to the binding.

mount-matrix is optional, so the basic node itself can stay in the dt.


Heiko
