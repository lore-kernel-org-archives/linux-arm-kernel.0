From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 15:33:46 +0200
Subject: [RFC PATCH 01/11] dma: amba-pl08x: Use bitmap to pass variant
 specific quirks
In-Reply-To: <CACRpkdbt4fAdnDKuP8bVpwrWoJ-oGNuSbiDZDz5J12ix2qijfQ@mail.gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <12368941.dQe8bcScGj@flatron>
 <CACRpkdbt4fAdnDKuP8bVpwrWoJ-oGNuSbiDZDz5J12ix2qijfQ@mail.gmail.com>
Message-ID: <201306181533.46905.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Linus Walleij wrote:
> I thought about it yesterday and it basically looks to me that
> it tries to outsmart the compiler on how to stuff the flags to save
> struct space on the heap and hint that they can be determined
> quickly by a & operation, this is like premature optimization.
> 
> So please go back to the old system.

Note that a 'bool' is typically stored as a 32-bit field, so there
would be some space saving if there are a lot of flags.

I agree with the conclusion though, the previous state was more
readable, which outweighs any benefits.

	Arnd
