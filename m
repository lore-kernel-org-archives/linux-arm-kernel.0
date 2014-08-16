From: tremyfr@gmail.com (Philippe Reynes)
Date: Sat, 16 Aug 2014 17:38:30 +0200
Subject: [RFC] usb issue on imx27: 3 clocks are needed
Message-ID: <53EF7AF6.2000405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

i.MX27's usb needs three clocks (usb_ipg_gate, usb_ahb_gate and usb_div)
but the current chipidea driver implementation, and devicetree, provides
only ipg and ahb. Consequently, if the bootloader don't enable the last
one, the kernel will crash.

Our approach/idea is to add a second, optionnal, clock in ci_hdrc_imx.c
with 'per' name in devicetree  and to add  clock name 'main_clk' for mandatory clock.
                   
This approach it correct? Or an other approach seems better?
                            
Thank you very much for your point of view.

Regards,
Philippe and Gwenhael
