From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Dec 2016 22:51:08 +0100
Subject: [PATCH] ARM: disallow ARM_THUMB for ARMv4 builds
In-Reply-To: <CAKv+Gu93Gtkh7spA-HUHNKSmDjhK_nuwR9KaDu8=S2GDyhUJCA@mail.gmail.com>
References: <20161216091457.2452987-1-arnd@arndb.de>
 <CAKv+Gu93Gtkh7spA-HUHNKSmDjhK_nuwR9KaDu8=S2GDyhUJCA@mail.gmail.com>
Message-ID: <4112999.Nl7pxYH1YF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 16, 2016 5:20:22 PM CET Ard Biesheuvel wrote:
> 
> Can't we use the old
> 
> tst lr, #1
> moveq pc, lr
> bx lr
> 
> trick? (where bx lr needs to be emitted as a plain opcode to hide it
> from the assembler)
> 

Yes, that should work around the specific problem in theory, but back
when Jonas tried it, it still didn't work. There may also be other
problems in that configuration.

	Arnd
