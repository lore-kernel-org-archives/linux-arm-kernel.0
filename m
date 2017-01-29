From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 29 Jan 2017 16:27:49 +0100 (CET)
Subject: [PATCH] ARM: bcm2835: dts: fix uart1 pinctrl node name
In-Reply-To: <81ee8da202abbe28e16352e80c1ff94c2e0628c2.1485695850.git.baruch@tkos.co.il>
References: <81ee8da202abbe28e16352e80c1ff94c2e0628c2.1485695850.git.baruch@tkos.co.il>
Message-ID: <1206842537.76132.1485703670020@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

> Baruch Siach <baruch@tkos.co.il> hat am 29. Januar 2017 um 14:17 geschrieben:
> 
> 
> Downstream kernel uses pins 32, 33 as UART0 (PL011) Rx/Tx to communicate with
> the Bluetooth chip. So ALT3 of these pins is most likely not CTS/RTS. Change
> the node name to reflect that.
> 
> With this change in place, adding
> 
>   &uart0 {
> 	 pinctrl-names = "default";
> 	 pinctrl-0 = <&uart0_gpio32 &gpclk2_gpio43>;
> 	 status = "okay";
>   };
> 
> to bcm2837-rpi-3-b.dts does the right thing on my Raspberry Pi 3.
> 
> Fixes: 21ff843931b ("ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> Should uart0_gpio30 be renamed to uart0_ctsrts_gpio30?

yes. According to the datasheet GPIO 30, 31 are for the flow control and GPIO 32, 33 are Tx, Rx.  Sorry for the delay, but i received your email only today via linux-rpi-kernel.

Please change the following in Version 2:

* s/uart1/uart0/ within the subject
* also fix uart0_gpio30 in the same patch

and you can add

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Btw could you please add the missing o in the comment above uart0_ctsrts_gpio16?

Thanks
Stefan
