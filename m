From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 22 Apr 2014 13:52:18 -0500
Subject: [PATCH] ARM: dts: am437x-gp-evm: Boot fixes
Message-ID: <1398192739-8901-1-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch, along with patch here [1], fixes boot for am437x-gp-evm. The
bootloader configures gpio5_7 to control the DDR3 termination regulator,
the linked patch prevents that gpio bank from being reset and losing
the previously configured state, and this patch binds the gpio to a
regulator so the kernel is aware of the state of the gpio.

[1] https://www.mail-archive.com/linux-omap at vger.kernel.org/msg102941.html

Dave Gerlach (1):
  ARM: dts: am437x-gp-evm: Add vtt_fixed regulator

 arch/arm/boot/dts/am437x-gp-evm.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
1.9.0
