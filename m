From: andy@warmcat.com (Andy Green)
Date: Mon, 14 Dec 2009 22:42:05 +0000
Subject: "ARM: MX3: fix CPU revision number detection" breaks QONG support
In-Reply-To: <20091214224109.20623gout4jbbdo5@webmail.epfl.ch>
References: <20091211143318.1D8B43F6CC@gemini.denx.de>	<20091211234714.GT28375@buzzloop.caiaq.de>	<20091214135722.CBCBF4C026@gemini.denx.de>	<20091214150420.GE28375@buzzloop.caiaq.de>
	<20091214224109.20623gout4jbbdo5@webmail.epfl.ch>
Message-ID: <4B26BF3D.2000000@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/09 21:41, Somebody in the thread at some point said:

Hi Valentin -

> The iim clock is explicitely enabled in clock.c, just before the call to
> mx31_read_cpu_rev(), and from what I had checked, the clock effectively
> seemed enabled for me. I have no clue about the register definition
> since I have found no real documentation about it, but from my point of
> view, this would more look like 8 bit registers as Andy pointed out in
> an earlier mail.

Some Google-fu last week got me this not very well publicised doucment:

  http://www.freescale.com/files/dsp/doc/app_note/AN3682.pdf

the fuse "memory map" is specific to iMX25, but it also documents the 
structure of Freescale's IIM peripheral register mapping, gives sample 
code (which works on iMX31, so presumably it deploys the same IIM IP).

The sample code is also entirely byte operations.

I don't think the globally unique CPU ID fuses are set by Freescale, 
because when I dumped the entire fuse space of a few iMX31 devices, 
there was only a handful of bytes that differed: I assumed these were 
stuff like die placement X Y.

Unfortunately Freescale did some "security by obscurity" in their main 
reference manual and while it talks about what kinds of fields are in 
the fuses, it doesn't give their bank and row indexes.  Annoyingly that 
information is right there in the iMX25-specific thing linked above.

-Andy
