From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Fri, 22 May 2015 23:28:50 -0500
Subject: [PATCH 0/3] ARM: socfpga: enable SMP for Arria10
Message-ID: <1432355333-15515-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Hi,

The goal of these 3 patches is to enable SMP on the Arria10 platform. During
the process, I found it would be much cleaner to convert the Cyclone5/Arria5
platform to use CPU_METHOD_OF_DECLARE instead of the machine descriptor.

The procedure to enable SMP on the Arria10 platform is similar to the Cyclone5/
Arria5 with the exception of a few differences in the register offset of the
reset manager designed to bring the secondary core out of reset. So instead of
littering the code with machine lookups, just use CPU_METHOD_OF_DECLARE.

Thanks,

Dinh Nguyen (3):
  ARM: socfpga: use CPU_METHOD_OF_DECLARE for socfpga_cyclone5
  ARM: socfpga: add CPU_METHOD_OF_DECLARE for Arria 10
  ARM: socfpga: dts: add enable-method property for cpu nodes

 arch/arm/boot/dts/socfpga.dtsi         |  1 +
 arch/arm/boot/dts/socfpga_arria10.dtsi |  1 +
 arch/arm/mach-socfpga/core.h           |  2 ++
 arch/arm/mach-socfpga/platsmp.c        | 32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/socfpga.c        |  1 -
 5 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.2.1
