From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 17 Dec 2015 16:41:29 -0800
Subject: [PATCH linux-next 0/5] mtd: spi-nor: add driver for Atmel QSPI
 controller
In-Reply-To: <20151218002901.GE10460@google.com>
References: <cover.1449494420.git.cyrille.pitchen@atmel.com>
 <20151207193441.GO120110@google.com>
 <A765B125120D1346A63912DDE6D8B6310BF53437@NTXXIAMBX02.xacn.micron.com>
 <20151218002901.GE10460@google.com>
Message-ID: <20151218004129.GF10460@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 04:29:01PM -0800, Brian Norris wrote:
> On Tue, Dec 08, 2015 at 06:21:00AM +0000, Bean Huo ??? wrote:

> OK, so I think your patch is broken:
> 
> > >     commit 548cd3ab54da ("mtd: spi-nor: Add quad I/O support for Micron
> > >     SPI NOR")
> 
> How did you test this? Specifically, this can't possibly have worked
> with a regular drivers/spi/ controllers, since:
> 
>  (a) you're enabling 4/4/4 (i.e., "Quad mode") on the flash but
>  (b) m25p80_read() only sets .rx_bits for the data; i.e., it's using
>  1/1/4 (i.e., "Extended mode")
> 
> I'm tempted to essentially revert that, as it looks essentially
> untested. It would be nice to have a cleaner baseline before trying to
> extend it with Cyrille's work.
> 
> Cyrille, what do you think? Is my analysis at all correct here? (Sorry
> if this is addressed elsewhere; there's a lot of text in this
> conversation, but I'm getting hung up very early.) And if so, does it
> hurt to just drop Micron "Quad mode" (4/4/4)?

It looks like you address some of this in patch 2, where you (as I do)
claim that Micron support is broken. It seems to me that it could be
better to kill it than to try to fix it. But maybe that's just the
frustrated maintainer in me speaking.

Brian
