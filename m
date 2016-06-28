From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 28 Jun 2016 18:10:31 -0400
Subject: [PATCH 0/2] arm: dts: syscon based reboot in DT
Message-ID: <1467151833-20767-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Splitting off the bcm5301x reset device tree changes from the patch
series (originally sent on http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/395155.html
and resent on https://lkml.org/lkml/2016/5/11/953) and adding a
Northstar Plus reset device tree change.

I'd like to get Arnd's ack/nack on these, as I am uncertain if I am
doing the correct thing based on the last email from him.  Per my
comment in the original email thread:

The CRU (Clock and Reset Unit) starts at 0x1800c100, with the
following layout:

CRU Clock Management at 0x1800c100-0x1800c180
CRU Reset at 0x1800c184
CRU Period Sample Clock at 0x1800c188
CRU Interrupt register at 0x1800c18c
CRU MDIO Control at 0x1800c190
CRU GPIO at 0x1800c1c0-0x1800c1e0
CRU SDIO 0x1800c200-0x1800c214
CRU RoboSW Interrupt at 0x1800c280
CRU Straps Control at 0x1800c2a0

The clock driver is already referencing the registers between
0x1800c100-0x1800c180, and the GPIO driver is referencing registers
between 0x1800c1c0-0x1800c1e0.

The reset part of the syscon seems to be the only useful thing in this
block.

So, are these patches acceptable given those constrains or am I better
off doing a reset driver that is more or less identical to
syscon-reboot?

Thanks,
Jon

Jon Mason (2):
  arm: dts: bcm5301x: Add syscon based reboot in DT
  arm: dts: nsp: Add syscon based reboot in DT

 arch/arm/boot/dts/bcm-nsp.dtsi  | 12 ++++++++++++
 arch/arm/boot/dts/bcm5301x.dtsi | 12 ++++++++++++
 2 files changed, 24 insertions(+)

-- 
1.9.1
