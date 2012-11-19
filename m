From: s.peter@mpl.ch (Stefan Peter)
Date: Mon, 19 Nov 2012 13:07:52 +0100
Subject: [PATCH 0/1] ARM: kirkwood: Convert the mplcec4 board to pinctrl
In-Reply-To: <20121119111838.GH10259@lunn.ch>
References: <cover.1353319919.git.s.peter@mpl.ch>
 <20121119111838.GH10259@lunn.ch>
Message-ID: <50AA2118.7050700@mpl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew

Am 19.11.2012 12:18, schrieb Andrew Lunn:
> On Mon, Nov 19, 2012 at 11:26:44AM +0100, Stefan Peter wrote:
>> Hello Andrew
>>
>> This is my try to convert the mplcec4 board to your pinctrl patches. The 
>> only problem I see is that I get an uart1 using mpp13 and mpp14 which
>> are used by the mvsdio driver
> 
> Hi Stefan
> 
> Interesting.
> 
> If you convert the dtb back to a dtc:
> 
> dtc -o mplcec4.dts -O dts arch/arm/boot/kirkwood-mplcec4.dtb
> 
> you see:
> 
> 		pinctrl at 10000 {

> 		};
> 	};
> 
> pmx-uart1 has no linux.phandle, and its not listed in 
> 
> pinctrl-0 = <0x2 0x3 0x4 0x5 0x6 0x7 0x8 0x9 0xa 0xb 0xc 0xd>;
> 
> so it should not be used as a pin hog.

Exactly.

> 
> So, during boot do you see:
> 
> f1012100.serial: ttyS1 at MMIO 0xf1012100 (irq = 34) is a 16550A
> 

No

> 
> What do you see in /debug/pinctrl/f1010000.pinctrl/pinmux-pins contain?
> 
> Since i have a second UART on my board i have:
> 
> pin 13 (PIN13): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function uart1 group mpp13
> pin 14 (PIN14): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function uart1 group mpp14
> 
> but i would expect to see function sdio.

No, I see

pin 12 (PIN12): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 13 (PIN13): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 14 (PIN14): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 15 (PIN15): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 16 (PIN16): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 17 (PIN17): (MUX UNCLAIMED) (GPIO UNCLAIMED)

However, there is a phandle in pinctrl at 10000/pmx-sdio/

> 
> Thanks
> 	Andrew
> 

Regards

Stefan Peter

-- 
MPL AG, Switzerland                     http://www.mpl.ch
Tel. +41 (0)56 483 34 34          Fax: +41(0)56 493 30 20
