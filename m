From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 21 Aug 2014 17:24:42 +0800
Subject: [PATCH v2 0/3] Introduce hix5hd2 IR transmitter driver
Message-ID: <1408613086-12538-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2:
Rebase to 3.17-rc1, solve two issues:
a) rc_set_allowed_protocols is deprecated
b) rc-ir-raw.c add empty change_protocol, which block using all protocol
For example, when rdev->map_name = RC_MAP_LIRC, ir-nec-decoder can not be used.

Guoxiong Yan (2):
  rc: Add DT bindings for hix5hd2
  rc: Introduce hix5hd2 IR transmitter driver

Zhangfei Gao (1):
  [media] rc: remove change_protocol in rc-ir-raw.c

 .../devicetree/bindings/media/hix5hd2-ir.txt       |   21 ++
 drivers/media/rc/Kconfig                           |   11 +
 drivers/media/rc/Makefile                          |    1 +
 drivers/media/rc/ir-hix5hd2.c                      |  347 ++++++++++++++++++++
 drivers/media/rc/rc-ir-raw.c                       |    7 -
 5 files changed, 380 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/hix5hd2-ir.txt
 create mode 100644 drivers/media/rc/ir-hix5hd2.c

-- 
1.7.9.5
