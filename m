From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 21 Jan 2014 07:10:24 +0000
Subject: Question: about wm8904's regulator consumer nodes 
Message-ID: <B256D81BAE5131468A838E5D7A24364172F64369@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Sorry to bother you.

There a board with a act8865 PMIC and wm8904 codec chip. But wm8904's powers is not supplied by any regulators, it is supplied directly.

1./ If enabling the CONFIG_REGULATOR, the wm8904 fails to probe with following message.

	wm8904 0-001a: Failed to get supply 'DCVDD': -19

2./ If adding the consumer nodes as below, the wm8904 works OK.

                         i2c1: i2c at f0018000 {
                                 wm8904: wm8904 at 1a {
                                         compatible = "wm8904";
                                         reg = <0x1a>;
 
                                         DCVDD-supply = <&vcc_1v8_reg>;
                                         DBVDD-supply = <&vddana_reg>;
                                         AVDD-supply = <&vcc_1v8_reg>;
                                         CPVDD-supply = <&vcc_1v8_reg>;
                                         MICVDD-supply = <&vddana_reg>;
                                 };
                          };

	But the power of DCVDD, DBVDD, AVDD, CPVDD and MICVDD is not supplied by any regulators, not the above regulator nodes.

	How do I deal with this case? Could you give me some advice?


Thank you in advance.

Best Regards,
Wenyou Yang
