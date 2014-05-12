From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 12 May 2014 16:11:38 +0200
Subject: [PATCH 0/2] ARM: mvebu: fix PCIe/mvebu-soc-id issue
Message-ID: <1399903900-29977-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This set of two patches (and more specifically the second patch) fix a
PCIe detection problem caused by the introduction of the mvebu-soc-id
and a bad interaction between the clock manipulation done by the
mvebu-soc-id code and the PCIe driver. The details are all in the
commit log of the second patch.

This second patch fixes a PCIe detection problem noticed by several
persons. The first patch is just a related preparation patch.

Both patches are meant for 3.15-rc, and should be backported to 3.14
as part of the stable process.

Best regards,

Thomas

Thomas Petazzoni (2):
  ARM: mvebu: mvebu-soc-id: add missing clk_put() call
  ARM: mvebu: mvebu-soc-id: keep clock enabled if PCIe unit is enabled

 arch/arm/mach-mvebu/mvebu-soc-id.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
1.9.2
