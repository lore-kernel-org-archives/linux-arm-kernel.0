From: swexru@gmail.com (Alexey Mednyy)
Date: Tue, 13 Sep 2016 00:47:40 +0300
Subject: iMX53 UART2 suspend freeze
Message-ID: <1385a087-44c6-1785-f74b-27bddbf8f3ac@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've met strange bug with mx53-qsb based board.

We use all 5 UART ports and I can say that on current UART2 with next 
configuration in device-tree :

         pinctrl_uart2: uart2grp {
             fsl,pins = <
                 MX53_PAD_PATA_BUFFER_EN__UART2_RXD_MUX    0x1e4
                 MX53_PAD_PATA_DMARQ__UART2_TXD_MUX    0x1e4
             >;
         };

&uart2 {
         pinctrl-names = "default";
         pinctrl-0 = <&pinctrl_uart2>;
         status = "okay";
};

prevents board from suspend.
That's happening at least since commit 
29add68d16474b7e8e3eadd94da4e909533b99d2 which is also suspend fixing 
commit.

All other ports UART1,3,4,5 suspending/resuming fine.

I don't know where do dig next I double checked pinctl settings and it 
seems like everything good there.

I've found that most of mx53 based boards with uart2 using the same 
muxing configuration.
I wonder if anybody else experiencing this issue?
same configured boards are:
imx53-smd.dts
imx53-tx53.dtsi - based
imx53-tqma53.dtsi -  based
imx53-m53evk.dts

_________________________________
Best regards, Mednyy Alexey.
