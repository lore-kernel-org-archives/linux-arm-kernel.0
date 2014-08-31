From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Sun, 31 Aug 2014 10:39:08 +0800
Subject: [PATCH v4 0/3] Introduce hix5hd2 IR transmitter driver
Message-ID: <1409452751-17463-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v4:
Change sequence and some comments from Sean and Varka

v3:
Got info from Mauro, 3.17 disable all protocol by default, specific protocol
can be selected via ir-keytable and /sys/class/rc/rc0/protocols

Got suggestion from Sean, add rdev specific info, like timeout, resoluton.
Add optional property "linux,rc-map-name", if kernel keymap is used
otherwise user space keymap will be used.

v2:
Rebase to 3.17-rc1, solve two issues:
a) rc_set_allowed_protocols is deprecated
b) rc-ir-raw.c add empty change_protocol, which block using all protocol
For example, when rdev->map_name = RC_MAP_LIRC, ir-nec-decoder can not be used.

Guoxiong Yan (2):
  rc: Add DT bindings for hix5hd2
  rc: Introduce hix5hd2 IR transmitter driver

Zhangfei Gao (1):
  ARM: dts: hix5hd2: add ir node

 .../devicetree/bindings/media/hix5hd2-ir.txt       |   25 ++
 arch/arm/boot/dts/hisi-x5hd2.dtsi                  |   10 +-
 drivers/media/rc/Kconfig                           |   11 +
 drivers/media/rc/Makefile                          |    1 +
 drivers/media/rc/ir-hix5hd2.c                      |  343 ++++++++++++++++++++
 5 files changed, 389 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/media/hix5hd2-ir.txt
 create mode 100644 drivers/media/rc/ir-hix5hd2.c

-- 
1.7.9.5
