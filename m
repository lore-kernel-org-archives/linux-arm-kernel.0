From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 16 May 2011 14:44:01 +0200
Subject: AT91: SPI: On implementing peripheral chip select decoding
In-Reply-To: <4DCFDBA6.6050007@techworks.ie>
References: <4DCFDBA6.6050007@techworks.ie>
Message-ID: <20110516124401.GA17895@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:56 Sun 15 May     , Christian Gagneraud wrote:
> Hi there,
> 
> The AT91SAM9G20 SPI controller (and possibly other SAM9 or other
> SoC) has the ability to work with CS decoding, thus allowing up to
> 15 peripherals with only 4 CS lines (CS[0:3]=0xF meaning no
> peripheral selected).
> I would like to know if anyone has experimented with this feature,
> or if anyone has advices/ideas on how to add support for this
> feature in the linux kernel.
As far as I remenber all at91 and avr32 have this
> 
> Before starting to work on this, I would like to know if this
> feature is common on other platforms or if it's AT91 specific.
> In the former case, it might be wise to include it in the SPI
> subsystem, and in the latter case keep it inside AT91 code.
Make it generic is always good but this can be extended to external Cs
extender as you can use any gpio to manage the Cs or a gpio extender on i2c

Best Regards,
J.
