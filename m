From: rene.wolf@mbda-systems.de (Wolf, Rene, HRO-GP)
Date: Mon, 23 Nov 2009 10:39:15 +0100
Subject: AW: MX3 SDMA?
In-Reply-To: <59b21cf20911191019v4b030b75qf383b3832607768a@mail.gmail.com>
References: <20091119172708.GN14091@buzzloop.caiaq.de>
	<59b21cf20911191019v4b030b75qf383b3832607768a@mail.gmail.com>
Message-ID: <87077C4F48609F4392621D9F99DDE20901202E30@tesla.star.galaxy.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

> The last attempt was made by someone in September but I didn't
> see any result at all:

I'm still waiting to get a green light on my work, sorry.

What I did was to port the API as found in LTIB to 2.6.31.
But I couldn't test it fully. I only tried to register a DMA chan.,
which works, and shows up in '/proc/sdma/channels'.
And as written in
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-September/001219.html
there's still SOME work ahead. For once, matching the conventions
among i.MX SoCs. The other thing is the binary code inside the SDMA
driver, wich will not be allowed inside the kernel and must be
ported to get loaded from user space.

If one wants to do this the clean way, I would suggest, writing an
assembler for the SDMA. The information provided in the official
reference manual of the i.MX31 should be sufficient for that. Then
one should analyze the API provided by LTIB and check how to get
the code up and running inside the SDMA. After that, a new and
clean API (the one from LTIB is quite confusing) must be written.

I hope that this will help somebody, coz I do not have the resources
at the moment, to either complete the first, or start the latter :-(


Cheers
Rene 



Rene Wolf
LFK-Lenkflugk?rpersysteme GmbH
Human Resources Operations & Policy, HRO
Landshuter Stra?e 26, 85716 Unterschlei?heim, GERMANY
Phone: +49 89 3179 8337
Fax: +49 8252 99 8964
E-Mail: rene.wolf at mbda-systems.de

http://www.mbda.net

Chairman of the Supervisory Board: Antoine Bouvier
Managing Director: Werner Kaltenegger
Registered Office: Schrobenhausen
Commercial Register: Amtsgericht Ingolstadt, HRB 4365

-----Urspr?ngliche Nachricht-----
Von: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-bounces at lists.infradead.org] Im Auftrag von Magnus Lilja
Gesendet: Donnerstag, 19. November 2009 19:19
An: Daniel Mack
Cc: Sascha Hauer; linux-arm-kernel at lists.infradead.org
Betreff: Re: MX3 SDMA?

Hi Daniel,

2009/11/19 Daniel Mack <daniel@caiaq.de>:
> Hi,
>
> I wonder whether anyone is currently working on porting the SDMA engie
> from Freescale's BSPs to mainline?
>
> If not, what would be a sane approach to start that? From what I've
> seen, there is support specifically for the SoC's on-chip peripherals
> which could be implemented with an API similar to the clock framework
> (ie, matching via device names).
>
> As this engine features an own RISC processor and is a huge monster, I
> would assume starting with supporting a subset of features would make
> sense.
>
> Plans, ideas?

The last attempt was made by someone in September but I didn't see any
result at all:
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-September/000886.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-September/001024.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/001806.html


Regards, Magnus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
