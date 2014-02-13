From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 13 Feb 2014 09:37:39 -0800
Subject: [PATCH v2 0/4] tty/serial: Add helpers to use GPIOs to control
 modem lines
In-Reply-To: <1392140715-15295-1-git-send-email-richard.genoud@gmail.com>
References: <1392140715-15295-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <20140213173739.GA31431@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 06:45:11PM +0100, Richard Genoud wrote:
> The USART controller on sam9x5 chips (and also all AT91/SAMA5 chips
> but at91rm9200) are not capable of handling DTR/DSR/DCD/RI signal.
> Moreover, even if the controller can handle CTS/RTS, the dedicated
> CTS/RTS pins are already muxed for other peripherals (LCDC/EMAC/MMC).
> 
> So this patchset adds the possibility to control those lines via GPIO,
> as it is done for RTS in the patch "switch atmel serial to use gpiolib"
> 
> As it was suggested by Alexander Shiyan, I made that available for
> every board.
> 
> This is based on 3.14-rc2 + Linus Walleij/Nicolas Ferre's patch:
>  354e57f3a0a2 ARM/serial: at91: switch atmel serial to use gpiolib
> (in Uwe's tree git://git.pengutronix.de/git/ukl/linux.git dropmachtimexh )
> and Philipp Zabel's patch:
> gpiolib: make gpiod_direction_output take a logical value, add gpiod_direction_output_raw
> (there won't be a merge conflict if this last patch is not present, the
> gpios will "just" be on the wrong direction.)
>  
> Tested on at91sam9g35, with a null modem cable between 2 serial ports,
> one with CTS/RTS controlled by the USART controller, the other via GPIO,
> full duplex transfers.
> Did some tests also with null modem cables on a PC.
> 
> Updates from v2:
> 	- Instead of controlling modem signal only on atmel board, the
> 	code is now available for every board.
> 	- The active low flag from device tree is now used.

I'm confused, how does this series relate to the previously sent 8 patch
series?

As I don't know what is going on, I'm going to drop both from my
to-apply queue, and await a new set of patches.

thanks,

greg k-h
