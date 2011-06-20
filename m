From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 20 Jun 2011 16:28:49 -0400 (EDT)
Subject: [PATCH] USB: ehci: use packed, aligned(4) instead of removing the
	packed attribute
In-Reply-To: <201106202207.23104.arnd@arndb.de>
References: <Pine.LNX.4.44L0.1106201240240.2113-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1106201306210.2142@xanadu.home>
	<4DFF85D6.1090104@ahsoftware.de> <201106202207.23104.arnd@arndb.de>
Message-ID: <alpine.LFD.2.00.1106201622160.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jun 2011, Arnd Bergmann wrote:

> On Monday 20 June 2011 19:39:34 Alexander Holler wrote:
> > That packed without an additional aligned() caused errors on ARM with 
> > gcc 4.6 is another problem which got (currently) fixed by removing packed.
> 
> Packed caused errors because it is *wrong*. The code as it was used undefined
> behavior in the language.

I wouldn't call this issue as such, but this is a Red herring.

Could you please provide a pointer to the structure definition so a 
second opinion to the usefulness of __packed there could be provided?  
If it is not matching any of the fairly limited cases where having 
__packed is relevant then we can just confirm that it should go.


Nicolas
