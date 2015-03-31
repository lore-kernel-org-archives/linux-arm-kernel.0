From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 31 Mar 2015 08:35:06 +0100
Subject: [PATCH RESEND 0/3] Enable ahci_st for stih407 and fix hang
Message-ID: <1427787309-1601-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Now that miphy28lp phy is present upstream we can add sata DT nodes for
stih407 family silicon. As part of testing this I found a hang
with the current driver implmentation which does some register writes
before enabling the IP clock. Presumably on stih416 devices the sata
clock must have already been enabled by the targetpack/bootloader.

This series also tidys up some inaccuracies in the DT documentation
where the doc hasn't kept aligned with the driver. In addtion to these
fixes I've also added an example for stih407 silicon.

Changes in RESEND:
- Rebased on v4.0-rc6 (Pete)
- Applied Acks (Pete)

Peter Griffin (3):
  ahci: st: Update the ahci_st DT documentation
  ARM: DT: STi: STiH407: Add sata DT nodes.
  ahci: st: st_configure_oob must be called after IP is clocked.

 Documentation/devicetree/bindings/ata/ahci-st.txt | 45 ++++++++++++++++-------
 arch/arm/boot/dts/stih407-family.dtsi             | 44 ++++++++++++++++++++++
 drivers/ata/ahci_st.c                             |  6 ++-
 3 files changed, 80 insertions(+), 15 deletions(-)

-- 
1.9.1
