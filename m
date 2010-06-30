From: lamiaposta71@gmail.com (Raffaele Recalcati)
Date: Wed, 30 Jun 2010 12:00:45 +0200
Subject: [PATCH] ASoC: DaVinci: Added support for cpu clocking I2S
In-Reply-To: <AANLkTimedG3X-rQbZvS6QfxUGkPIAtCgliI0xWknmNA9@mail.gmail.com>
References: <1277707487-3371-1-git-send-email-lamiaposta71@gmail.com>
	<20100628103030.GB14247@rakim.wolfsonmicro.main>
	<AANLkTimedG3X-rQbZvS6QfxUGkPIAtCgliI0xWknmNA9@mail.gmail.com>
Message-ID: <AANLkTilqE9E2lFwCKu5hx0EYZajIWubM7Qzf_n3vQfLq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The freq problem is describe here below, but it is not clear to me:
>
> From *TMS320DM36x DMSoC Multichannel Buffered Serial Port User's Guide
> (Rev. A) <http://www.ti.com/litv/pdf/sprufi3a>*
> 2.5.3 Data Clock Generation
> When the receive/transmit clock mode is set to 1 (CLK(R/X)M = 1 in the pin
> control register (PCR)), the
> data clocks (CLK(R/X)) are driven by the internal sample rate generator
> output clock, CLKG. You can
> select for the receiver and transmitter from a variety of data bit clocks
> including:
> ? The input clock to the sample rate generator, which can be either the
> internal clock source or a
> dedicated external clock source via the MCBSP_CLKX, MCBSP_CLKR, or
> MCBSP_CLKS pins. The
> McBSP internal clock is the CPU/6 clock. See Section 2.5.3.1 for details on
> the source of the McBSP
> internal clock.
> ? The input clock source (internal clock source or external clock
> MCBSP_CLKX/MCBSP_CLKR/MCBSP_CLKS) to the sample rate generator can be
> divided-down by a
> programmable value (CLKGDV bit in the sample rate generator register
> (SRGR)) to drive CLKG.
> Regardless of the source to the sample rate generator, the rising edge of
> CLKSRG (see Figure 5)
> generates CLKG and FSG.
>
> CPU/6 is not clear.
>


Reading better the documentation the point seems now clear.
We have pllc1 sysclk4 that is the clock of McBSP peripheral.
And so it was abviously this frequency to be used when McBSP has to generate
the clock.
Sorry..

Raffaele
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100630/cd36af45/attachment.html>
