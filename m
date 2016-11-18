From: peda@axentia.se (Peter Rosin)
Date: Fri, 18 Nov 2016 15:08:12 +0100
Subject: [PATCH v2 0/2] Support for Axentia TSE-850
Message-ID: <1479478094-20288-1-git-send-email-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

changes v1 -> v2
- squash the fixup into the correct patch, sorry for the noise.

After finally having all essintial drivers upstreamed (the
last ones are currently in -next) I would like to have the
dts and the defconfig also upstreamed.

checkpatch complains about missing docs for some compatible
strings:

axentia,tse850v3   (v3 is the hw version that we currently use)
axentia,tse850     (in case we have future versions with commonality)
axentia,linea      (the cpu module, reused in other products as well)
nxp,se97b          (temp sensor in the below eeprom module)
nxp,24c02          (eeprom on the main board)
st,24c64           (eeprom on the cpu module)

I don't know where I should document those, or if it's even
needed? I get the feeling that the last three are not "my fault".
Anyway, please advice. Or, even better, apply as-is... :-)

Cheers,
Peter

Peter Rosin (2):
  ARM: dts: add devicetree for the Axentia TSE-850
  ARM: tse850_defconfig: add Axentia TSE-850

 MAINTAINERS                            |   7 +
 arch/arm/boot/dts/Makefile             |   1 +
 arch/arm/boot/dts/axentia-linea.dtsi   |  52 +++++++
 arch/arm/boot/dts/axentia-tse850-3.dts | 275 +++++++++++++++++++++++++++++++++
 arch/arm/configs/tse850_defconfig      | 223 ++++++++++++++++++++++++++
 5 files changed, 558 insertions(+)
 create mode 100644 arch/arm/boot/dts/axentia-linea.dtsi
 create mode 100644 arch/arm/boot/dts/axentia-tse850-3.dts
 create mode 100644 arch/arm/configs/tse850_defconfig

-- 
2.1.4
