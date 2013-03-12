From: jhovold@gmail.com (Johan Hovold)
Date: Tue, 12 Mar 2013 22:17:02 +0100
Subject: [PATCH] ARM: w1-gpio: fix erroneous gpio requests
In-Reply-To: <FE853F2C-A85A-4D0E-BF0E-80698F3E6567@jcrosoft.com>
References: <1363116094-8630-1-git-send-email-jhovold@gmail.com>
 <20130312202028.GA6060@kroah.com>
 <FE853F2C-A85A-4D0E-BF0E-80698F3E6567@jcrosoft.com>
Message-ID: <20130312211702.GG8797@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 04:24:20AM +0800, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On Mar 13, 2013, at 4:20 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > On Tue, Mar 12, 2013 at 08:21:34PM +0100, Johan Hovold wrote:
> >> Fix regression introduced by commit d2323cf773 ("onewire: w1-gpio: add
> >> ext_pullup_enable pin in platform data") which added a gpio entry to the
> >> platform data, but did not add the required initialisers to the board
> >> files using it. Consequently, the driver would request gpio 0 at probe,
> >> which could break other uses of the corresponding pin.
> >> 
> >> On AT91 requesting gpio 0 changes the pin muxing for PIOA0, which, for
> >> instance, breaks SPI0 on at91sam9g20.
> 
> not only on AT91, 0 is a valid gpio

AT91 (and 9g20) was just an example of what the implications could be
like.

I discovered the change after having debugged broken MMC on a custom
at91sam9g45 board.

Johan
