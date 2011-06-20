From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 20 Jun 2011 17:03:17 -0400 (EDT)
Subject: [PATCH] USB: ehci: use packed,
	aligned(4) instead of removing the packed attribute
In-Reply-To: <201106202239.31997.arnd@arndb.de>
References: <Pine.LNX.4.44L0.1106201240240.2113-100000@iolanthe.rowland.org>
	<201106202207.23104.arnd@arndb.de>
	<alpine.LFD.2.00.1106201622160.2142@xanadu.home>
	<201106202239.31997.arnd@arndb.de>
Message-ID: <alpine.LFD.2.00.1106201658330.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jun 2011, Arnd Bergmann wrote:

> On Monday 20 June 2011 22:28:49 Nicolas Pitre wrote:
> > On Mon, 20 Jun 2011, Arnd Bergmann wrote:
> > 
> > > On Monday 20 June 2011 19:39:34 Alexander Holler wrote:
> > > > That packed without an additional aligned() caused errors on ARM with 
> > > > gcc 4.6 is another problem which got (currently) fixed by removing packed.
> > > 
> > > Packed caused errors because it is *wrong*. The code as it was used undefined
> > > behavior in the language.
> > 
> > I wouldn't call this issue as such, but this is a Red herring.
> > 
> > Could you please provide a pointer to the structure definition so a 
> > second opinion to the usefulness of __packed there could be provided?  
> 
> The structures in question are ehci_caps, ehci_regs and ehci_dbg_port.

OK.  If anyone was still entertaining any doubts, those structures do 
not require any packed attribute what so ever.

> The patch that remove the __packed attribute was 139540170 "USB: ehci:
> remove structure packing from ehci_def".

Too late for this, but for the record:

Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Hopefully this thread still gathered enough wisdom about proper usage of 
the packed and aligned attributes into the list archive.


Nicolas
