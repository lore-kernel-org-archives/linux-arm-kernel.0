From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Jun 2011 22:07:22 +0200
Subject: [PATCH] USB: ehci: use packed,
	aligned(4) instead of removing the packed attribute
In-Reply-To: <4DFF85D6.1090104@ahsoftware.de>
References: <Pine.LNX.4.44L0.1106201240240.2113-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1106201306210.2142@xanadu.home>
	<4DFF85D6.1090104@ahsoftware.de>
Message-ID: <201106202207.23104.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 June 2011 19:39:34 Alexander Holler wrote:
> That packed without an additional aligned() caused errors on ARM with 
> gcc 4.6 is another problem which got (currently) fixed by removing packed.

Packed caused errors because it is *wrong*. The code as it was used undefined
behavior in the language.

> But this introduces imho doubts and uncertainty about if padding bytes 
> could be between the members, therefore I would prefer to use packed 
> with aligned instead of removing the packed.

Packing was never an issue here, please stop talking about it.

	Arnd
