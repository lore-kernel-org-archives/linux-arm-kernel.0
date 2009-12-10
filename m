From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 10 Dec 2009 16:19:41 +0800
Subject: [PATCH] pxa/zeus: Allow use of 8250-compatible UART in uncompress
In-Reply-To: <20091210090949.35ae1a1b@hina.wild-wind.fr.eu.org>
References: <20091210073922.79f6e841@taxman.wild-wind.fr.eu.org>
	<20091210071208.GL28375@buzzloop.caiaq.de>
	<20091210090949.35ae1a1b@hina.wild-wind.fr.eu.org>
Message-ID: <20091210081940.GB28539@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2009 at 09:09:49AM +0100, Marc Zyngier wrote:
> On Thu, 10 Dec 2009 15:12:08 +0800
> Daniel Mack <daniel@caiaq.de> wrote:
> 
> > ... with UART being char* now (and as UART_REG is just a macro) it
> > will only be 8 bits in width, and hence all logic that accesses bits
> > beyond that scope wil fail. Tricky casting might help here, but your
> > referencing that as an array, so the value will be &= 0xff.
> > Or did I overlook anything?
> 
> Well, all registers are actually 8bit wide. So I feel like using char*
> is actually one step closer to the actual behavior of the hardware.
> Unless I in turn overlooked something else... ;-)

Ah ok, I missed that. Would be good to hve a comment stating that, for
the next one to stumble over it :)

Daniel
