From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 21 Mar 2016 11:01:37 -0500
Subject: Series adding Arria10 L2 Cache EDAC 
Message-ID: <1458576106-24505-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This version refactors how the EDAC is configured for Arria10 since
the ECC hardware is significantly different than Cyclone5 and Arria5.
Since all the IRQs are shared, a new probe function based on the 
xgene codebase was used.

[PATCHv3 1/9] EDAC: Altera L2 Kconfig change from select to depends
[PATCHv3 2/9] EDAC, altera: Move Device structs and defines to
[PATCHv3 3/9] EDAC, altera: Remove platform device from check_deps()
[PATCHv3 4/9] EDAC, altera: Abstract ECC Enable Mask in check_deps()
[PATCHv3 5/9] EDAC, altera: Add register offset for ECC Error Inject
[PATCHv3 6/9] Documentation: dt: socfpga: Add Altera Arria10 L2
[PATCHv3 7/9] EDAC, altera: Addition of Arria10 L2 Cache ECC
[PATCHv3 8/9] ARM: socfpga: Enable Arria10 L2 cache ECC on startup
[PATCHv3 9/9] ARM: dts: Add Altera Arria10 L2 Cache EDAC devicetree
