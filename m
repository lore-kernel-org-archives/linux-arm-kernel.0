From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Aug 2016 17:37:28 +0200
Subject: [PATCH 0/2] STi: Add ports-implemented property support
Message-ID: <1470843450-20068-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Despite ST AHCI version = 1.3, reading HOST_PORTS_IMPL
returns 0. So force HOST_PORTS_IMPL to 1 by using
ports-implemented DT property.
Update achci_st driver and STi dts accordingly

Patrice Chotard (2):
  ahci: st: Add ports-implemented property in support
  ARM: dts: STiH407-family: Add ports-implemented property in sata nodes

 arch/arm/boot/dts/stih407-family.dtsi | 4 ++++
 drivers/ata/ahci_st.c                 | 4 ++++
 2 files changed, 8 insertions(+)

-- 
1.9.1
