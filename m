From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 12 Mar 2013 13:20:28 -0700
Subject: [PATCH] ARM: w1-gpio: fix erroneous gpio requests
In-Reply-To: <1363116094-8630-1-git-send-email-jhovold@gmail.com>
References: <1363116094-8630-1-git-send-email-jhovold@gmail.com>
Message-ID: <20130312202028.GA6060@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 08:21:34PM +0100, Johan Hovold wrote:
> Fix regression introduced by commit d2323cf773 ("onewire: w1-gpio: add
> ext_pullup_enable pin in platform data") which added a gpio entry to the
> platform data, but did not add the required initialisers to the board
> files using it. Consequently, the driver would request gpio 0 at probe,
> which could break other uses of the corresponding pin.
> 
> On AT91 requesting gpio 0 changes the pin muxing for PIOA0, which, for
> instance, breaks SPI0 on at91sam9g20.
> 
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Johan Hovold <jhovold@gmail.com>
> ---
> 
> Not sure whose tree this should go in through, so adding relevant maintainers
> and authors as CC.

As I took the offending patch, I might as well take this fix for it as
well.

Unless anyone else objects?

thanks,

greg k-h
