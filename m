From: horms@verge.net.au (Simon Horman)
Date: Mon, 8 Nov 2010 10:57:14 +0900
Subject: [patch v3 2/2] ARM: mach-shmobile: Add zboot support for
	SuperH Mobile ARM
In-Reply-To: <20101107172310.GG1759@n2100.arm.linux.org.uk>
References: <20101014091231.858799238@vergenet.net>
	<20101014091434.501864612@vergenet.net>
	<20101107172310.GG1759@n2100.arm.linux.org.uk>
Message-ID: <20101108015714.GB15671@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 07, 2010 at 05:23:10PM +0000, Russell King - ARM Linux wrote:
> On Thu, Oct 14, 2010 at 06:12:33PM +0900, Simon Horman wrote:
> > +LIST "partner-jet-setup.txt"
> > +LIST "(C) Copyright 2010 Renesas Solutions Corp"
> > +LIST "Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>"
> > +
> > +LIST "RWT Setting"
> > +EW 0xE6020004, 0xA500
> > +EW 0xE6030004, 0xA500
> 
> Can you explain the necessity of this special scripting language, and
> where it comes from?
> 
> It looks like the file implementing the scripting language comes from
> something other than Linux, but it isn't clear what the licensing is
> of that.  Please confirm that it is GPL'd.

Hi Russell,

The aim is to allow JTAG scripts to be used in-place.
The script is constructed from ASM macros which are defined
in arch/arm/mach-shmobile/include/mach/zboot_macros.h which is
included later on in the patch. The same macros exist in SH assembly
in arch/sh/include/asm/romimage-macros.h.

With regards to the license, I have confirmed that it is GPL.
Would you be more comfortable if that was stated explicitly
in the new files?
