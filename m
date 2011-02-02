From: subaparts@yandex.ru (Alexander Sverdlin)
Date: Wed, 02 Feb 2011 16:26:51 +0300
Subject: [PATCH] EDB93xx: Add support for CS4271 CODEC on EDB93xx boards
In-Reply-To: <20110202125327.GO12743@opensource.wolfsonmicro.com>
References: <1296603653.1504.9.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEF59B2B@AUSP01VMBX24.collaborationhost.net>
	<1296643688.1504.23.camel@r60e>
	<20110202104943.GN12743@opensource.wolfsonmicro.com>
	<1296645167.1504.31.camel@r60e>
	<20110202125327.GO12743@opensource.wolfsonmicro.com>
Message-ID: <1296653211.1504.40.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark, Dear Hartley,

On Wed, 2011-02-02 at 12:53 +0000, Mark Brown wrote:
> > Now Hartley suggested to move GPIO handling to platform code. This makes
> > sense, as SPI-enable will be managed automatically, and reset is also
> > more related to platform (depending on schematics, inversion and so on).
> 
> What is the advantage of this?  The GPIO management has to be done
> somewhere and replicating it in every platform seems like a complete
> waste of time.  Given that one of the GPIOs is a power control it'll
> also mean that it's not possible to manage the power dynamically at
> runtime.
> 

I think we can leave reset management in CODEC (as it will be almost the
same for all platforms), leave enable pin management in CODEC unused,
but attach enable GPIO to spi_board_info in platform to enable other SPI
devices on bus.

Hartley, in this case we cannot use existing cs4271_platform_data and
have to leave long if-else statemens as is. Would it be ok?

Best regards,
	Alexander.
