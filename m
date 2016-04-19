From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Tue, 19 Apr 2016 17:39:00 -0500
Subject: [PATCH 0/3] arm64: defconfig updates
Message-ID: <1461105540-23799-1-git-send-email-stuart.yoder@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series was based on 4.6-rc4.

As far as I know, when doing a 'make defconfig' immediately followed by 
'make savedefconfig', the resulting defconfig should exactly match
the original defconfig.  This was not the case for arm64 and patch 1 cleans
that up.

Patch 2 enables 48-bit VA to allow certain armv8 SoCs to cover all of
their physical memory regions. (see email thread:
http://www.spinics.net/lists/arm-kernel/msg497210.html)

Patch 3 enables some additional device for Freescale/NXP SoCs.

Stuart Yoder (3):
  arm64: defconfig: cleanup the defconfig
  arm64: defconfig: enable 48-bit virtual addresses
  arm64: defconfig: enable freescale/nxp config options

 arch/arm64/configs/defconfig | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
1.9.0
