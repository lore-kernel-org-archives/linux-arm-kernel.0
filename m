From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Aug 2011 23:44:50 +0200
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <4E568E6C.60904@gmail.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<201108251802.29251.arnd@arndb.de> <4E568E6C.60904@gmail.com>
Message-ID: <3676282.cOZ2dSAjhH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 August 2011 13:03:24 Rob Herring wrote:
> > 
> > Do you mean 'yes, they need to be global' or 'yes, it's better to export
> > the functions'?
> > 
> 
> I meant the former and functions as in h/w functionality, not C functions.
> 
> This will mainly be clock control plus a few other things. Is it really
> desired to add another layer here when these are all just single
> register writes?

It really depends on what the registers do, which I haven't seen. My feeling
is still that you should have an abstract interface for drivers to use,
but if the drivers need to do very little, exporting the symbol for the
base address and using it in inline functions from the header could be
appropriate.

	Arnd
