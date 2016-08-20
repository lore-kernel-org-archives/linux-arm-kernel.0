From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Sat, 20 Aug 2016 23:04:44 +0300
Subject: [PATCH v2 0/7] ARM: dts: imx: add gpio-ranges properties to some iMX
 GPIO controllers
Message-ID: <1471723491-15330-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

% gawk -n '{ sub(/.*__/, ""); if ($1 ~ "^GPIO") print $1, $2/4}' \
	arch/arm/boot/dts/imxXX-pinfunc.h | sort -n

Note that this means that potential errors in arch/arm/boot/dts/imx*-pinfunc.h
descriptions may migrate to this change, please double check the values.

If needed similar changes may be done for the rest of iMX SoCs.

Changes from v1 to v2:
* in copy-pasted commit messages corrected SoC names

Vladimir Zapolskiy (7):
  ARM: dts: add gpio-ranges property to iMX50 GPIO controllers
  ARM: dts: add gpio-ranges property to iMX6Q/D GPIO controllers
  ARM: dts: add gpio-ranges property to iMX6DL/S GPIO controllers
  ARM: dts: add gpio-ranges property to iMX6SL GPIO controllers
  ARM: dts: add gpio-ranges property to iMX6SX GPIO controllers
  ARM: dts: add gpio-ranges property to iMX6UL GPIO controllers
  ARM: dts: add gpio-ranges property to iMX7D/S GPIO controllers

 arch/arm/boot/dts/imx50.dtsi  | 16 +++++++++++++
 arch/arm/boot/dts/imx6dl.dtsi | 53 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi  | 37 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6sl.dtsi | 52 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6sx.dtsi | 14 ++++++++++++
 arch/arm/boot/dts/imx6ul.dtsi | 11 +++++++++
 arch/arm/boot/dts/imx7s.dtsi  | 14 ++++++++++++
 7 files changed, 197 insertions(+)

-- 
2.8.1
