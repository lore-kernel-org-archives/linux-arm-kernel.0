From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Jul 2014 12:32:36 +0100
Subject: [PATCH] ARM: at91: spi: request all csgpio in spi probe
In-Reply-To: <20140728223859.GA3214@piout.net>
References: <b033d16ec31d26a895726ee72ec89b43943dfbae.1406547656.git.jiri.prchal@aksignal.cz>
 <20140728122103.GR9532@piout.net> <53D64ADA.1000102@aksignal.cz>
 <20140728223859.GA3214@piout.net>
Message-ID: <20140729113236.GM17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 12:38:59AM +0200, Alexandre Belloni wrote:

> Mark: maybe it would make sense to do devm_gpio_request_one() in
> of_spi_register_master(), after of_get_named_gpio.

You need to transition all the drivers doing things manually but yes.
As I keep saying all the GPIO handling needs to be completely
refactored.

> While this solves the particular issue Ji?? is seeing, this will not
> solve the case where PA14 (CS0) is not used by the spi driver at all. It
> will remained muxed as CS0 and toggle when the spi master needs to
> access CS0 until another driver muxes it to something else. I still
> believe we should explicitly ask pinctrl to mux them as gpios.

I'm just guessing as to what the issue that he's seeing is but isn't
this just saying that the board pinmuxing is wrong?  If the board
doesn't want the pin to be used by the SPI controller it shouldn't be 
configuring it that way.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/77c3082f/attachment.sig>
