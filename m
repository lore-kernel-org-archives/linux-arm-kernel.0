From: voice.shen@gmail.com (Bo Shen)
Date: Mon, 15 Oct 2012 10:53:55 +0800
Subject: dts: question about how to configure PIO used as i2c irq
Message-ID: <507B7AC3.7090904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,
   When moving atmel qt1070 linux driver with DT support. The atmel 
qt1070 is an I2C device. I meet the following questions.

   The qt1070 DT node
   --<--------------
   qt1070: keyboard@1b {
         compatible = "atmel,qt1070";
         reg = <0x1b>;
         interrupt-parent = <&pioA>;
         interrupts = <7 0x0>;
   };
   -->--------------

   DT will parse this node and map irq, the i2c_client->irq. This can be 
used directly in atmel qt1070 driver. However, the PIO which used as irq 
need configure as a PIO input. Now, we can not use irq_to_gpio() 
function to convert irq to gpio. So, if we can not configure this gpio.

   If we configure the pio in board-dt.c, I think this is not a good 
place. For example, if the kernel image support multiplatform, while on 
these platform, using different pio for qt1070, so this will cause only 
one platform can use qt1070.

   So, for this question, how should I solve it? Would you please give 
me some advice?
