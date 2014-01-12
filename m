From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 12 Jan 2014 21:21:19 +0100
Subject: DT include files
In-Reply-To: <20140112032516.GA23525@S2101-09.ap.freescale.net>
References: <20140103023211.GA25079@S2101-09.ap.freescale.net>
 <201401111415.29395.arnd@arndb.de>
 <20140112032516.GA23525@S2101-09.ap.freescale.net>
Message-ID: <201401122121.20084.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 12 January 2014, Shawn Guo wrote:
> Let's say the mux option SPDIF_OUT of pin GPIO_17 is used on a few board
> designs, hummingboard, nitrogen6x and wandboard.  If we do not use
> macro, every author of these board dts files need to look into reference
> manual to find out the following numbers
> 
>  - The mux register offset of pin GPIO_17
>  - The select input register offset of pin GPIO_17
>  - The config register offset of pin GPIO_17
>  - The value of SPDIF_OUT mux option for GPIO_17
>  - The select input value of SPDIF_OUT mux option for GPIO_17
> 
> , and then code these numbers in their <board>.dts by hand.  It's
> boring and error prone.  As a comparison, we generate these numbers
> from reference manual database using a tool and define a macro
> MX6QDL_PAD_GPIO_17__SPDIF_OUT for these numbers.  The authors only need
> to find out this macro from imx6q-pinfunc.dtsi and fill it into his dts.
> Isn't the macro use here helping to ease everyone's life and make the
> coding less error prone, since the macro is generated from database?

I was under the impression that the generic pinctrl binding was designed
in a way to let you assign labels to each possible (reasonable)
configuration so you didn't have get to this level of detail at the
driver. I'm also surprised that you have to know multiple constants
(mux register, input register, config register offsets) to select a
particular pin. I would have expected that you could have one constant
from which the driver is able to compute the other ones.

If you actually need the complexity that you describe in the board files,
the macros don't seem worse than the alternative, I would just be happier
if the pinctrl driver binding could do without them.

	Arnd
