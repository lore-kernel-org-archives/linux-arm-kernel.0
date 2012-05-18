From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 18 May 2012 14:46:26 -0600
Subject: db8500.dtsi: ab8500@5 reg property invalid length
Message-ID: <4FB6B522.4050301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee,

In commit 3de3d74 "ARM: ux500: Configure the PRCMU Timer for db8500
based devices in DT", you changed DT node prcmu at 80157000's #size-cells
from 0 to 1, but didn't adjust the reg property for existing sub-node
ab8500 at 5. Also, the indentation of the new subnode
prcmu-timer-4 at 80157450 looks wrong.

This makes dtc fail to compile snowball.dts:

Warning (reg_format): "reg" property in
/soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes)
(#address-cells == 1, #size-cells == 1)
