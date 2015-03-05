From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 5 Mar 2015 18:35:36 +0800
Subject: parent/child hierarchy for regulator
Message-ID: <20150305103534.GA19600@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi lists,

Any good ways at code/dts to show parent/child hierarchy for regulator?

The related regulators at my platforms like below:
PMIC (SWB 5v) --> Switch Chip (GPIO Regulator) --> USB VBUS

PMIC has one 5V regulator (eg, swbst at pfuse), and it is the input
for USB power switch chip, and there are two gpios at this switch
chip to control if 5V is output or not, we register these two gpios as 
fixed regulators, currently, if regulator swbst is disabled, the
gpio regulator has no way to know, and cause the vbus voltage is wrong.

Thanks in advance.

-- 

Best Regards,
Peter Chen
