From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Jun 2011 22:20:01 +0200
Subject: [PATCH] USB: ehci: use packed,
	aligned(4) instead of removing the packed attribute
In-Reply-To: <4DFA634D.6000907@ahsoftware.de>
References: <Pine.LNX.4.44L0.1106161541260.1697-100000@iolanthe.rowland.org>
	<4DFA634D.6000907@ahsoftware.de>
Message-ID: <201106162220.02185.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 June 2011 22:10:53 Alexander Holler wrote:
> Using packed doesn't seem to be necessary (at least not with those 
> versions of gcc I'm using here), I've tried both versions (on arm, 
> without packed and with packed, aligned(4)) and both are working. I've 
> only posted the patch because I found the usage of packed, aligned(4) 
> much clearer than without packed. And It might help avoiding such 
> discussions like this with people like me who aren't that deep involved 
> in gcc-specific implementation details. ;)
> 
> Anyway, feel free to nack that patch. I don't really care and just 
> thought I should post it (e.g. as an alternative to removing that packed).

At least I would be happier without the patch. I'm trying to convince
people to not use these attributes unless required because too much
harm is done when they are used without understanding the full
consequences. I also recommend using __packed as localized as possible,
i.e. set it for the members that need it, not the entire struct.

I agree that your patch is harmless, it's just the opposite of
a cleanup in my opinion.

	Arnd
