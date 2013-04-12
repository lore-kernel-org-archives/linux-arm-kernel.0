From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 12 Apr 2013 13:57:43 +0200
Subject: [PATCH v3] clk: add device tree fixed-factor-clock binding support
Message-ID: <1365767864-7829-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Since august this patch finally find a user:
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arc/boot/dts/abilis_*.dtsi.
So I resusrected this patch with small changed suggested by Christian
Ruppert.

Mike,
if you still agree with this patch, you can apply it.
It was based on 3.9-rc6 but it can also be applied on clk-next
without any conflict.

Changelog:
v2 -> v3

- Updating the binding documentation bu using clock-div and clock-mul
  instead of div and mul
- Adding the tested-by tag from by Christian Ruppert

v1 -> v2
- Adding CLK_OF_DECLARE
- Using IS_ERR to test the clk value

Thanks,

Gregory CLEMENT (1):
  clk: add device tree fixed-factor-clock binding support

 .../bindings/clock/fixed-factor-clock.txt          |   24 +++++++++++++
 drivers/clk/clk-fixed-factor.c                     |   36 ++++++++++++++++++++
 include/linux/clk-provider.h                       |    2 ++
 3 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fixed-factor-clock.txt

-- 
1.7.9.5
