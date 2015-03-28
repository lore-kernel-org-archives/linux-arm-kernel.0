From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 28 Mar 2015 19:20:48 +0100
Subject: [RFC 1/6] atmel: add atmel_io.h
In-Reply-To: <20150326115123.GA16148@samfundet.no>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427370354-21247-2-git-send-email-ben.dooks@codethink.co.uk>
 <20150326115123.GA16148@samfundet.no>
Message-ID: <20150328182048.GE4021@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26/03/2015 at 12:51:23 +0100, Hans-Christian Egtvedt wrote :
> Around Thu 26 Mar 2015 11:45:49 +0000 or thereabout, Ben Dooks wrote:
> > The AVR32 and ARM (AT91) architectures share a number of drivers which
> > need to access the on chip peripherals. The current drivers work with
> > the default endian configuration, however it is possilbe to run some of
> > the ATMEL ARM architectures in big endian mode.
> > 
> > If we change the drivers from __raw to _relaxed IO accesors then the ARM
> > side works but the AVR32 will not. The _relaxed assume the bus is little
> > endian and the __raw are native. The AVR32 is native big endian so these
> > are not the right functions.
> > 
> > To sort this out, and avoid a number of drivers having #ifdef for the
> > AVR32 case we add <linux/atmel_io.h> to provide some AT91/AVR32 independant
> > IO accessor functions.
> > 
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> 

Is there any reason why read/write[bwl]_relaxed can't be made to do big
endian accesses on avr32?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
