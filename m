From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 13 Dec 2014 21:36:16 +0100
Subject: clk: mxs: Invalid register access on HW_CLKCTRL_FRAC0?
In-Reply-To: <1022343616.100338.1418473409091.JavaMail.open-xchange@oxbaltgw00.schlund.de>
References: <1022343616.100338.1418473409091.JavaMail.open-xchange@oxbaltgw00.schlund.de>
Message-ID: <20141213203616.GX13486@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 13, 2014 at 01:23:29PM +0100, Stefan Wahren wrote:
> Hi Fabio,
> 
> yesterday i stumble on this note in the i.MX28 reference manual (p. 931):
(when talking page numbers it's usually helpful to also specify the
document more exactly. I use "i.MX28 Applications Processor Reference
Manual Rev2, 08/2013", the page number seems to match.)

>     10.8.24 Fractional Clock Control Register 0 (HW_CLKCTRL_FRAC0)
> 
>     NOTE: This register can only be addressed by byte instructions. Addressing
> word or half-word are not allowed.
> 
> The same applies to HW_CLKCTRL_FRAC1.
Bah, looking at the example code for this register:

	*((u8 *)(HW_CLKCTRL_FRAC0_ADDR + 1)) = 30;

without any further comment.  The documentation writes could at least
have added:

	Assuming little endian operation this command sets EMIFRAC=0x1e
	and CLKGATEEMI=0.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
