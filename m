From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 20 Feb 2014 14:24:33 +0000
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <20140220132320.GP11878@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <52F51922.6030502@gmail.com>
 <1392892217.23342.18.camel@kazak.uk.xensource.com>
 <20140220105854.GL11878@lunn.ch>
 <1392896076.23342.37.camel@kazak.uk.xensource.com>
 <20140220121821.GO11878@lunn.ch>
 <1392900664.23342.60.camel@kazak.uk.xensource.com>
 <20140220132320.GP11878@lunn.ch>
Message-ID: <1392906273.30563.14.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-02-20 at 14:23 +0100, Andrew Lunn wrote:
> > > What this patchset does is also make mach-mvebu part of the multi v5
> > > kernel. So you just need one kernel for all ARM v5 machines which are
> > > part of multi v5. The long term goal is that you need just two 32 ARM
> > > kernels, multi v5 and multi v7. However orion5x and mv76xx0 are not
> > > yet part of theses, so we are not there yet.
> > 
> > So in answer to my question, on v5 ARCH_KIRKWOOD and ARCH_MVEBU *cannot*
> > coexist in the same binary?
> 
> Clearly ARCH_MVEBU v7 cannot.

Yes, sorry, I meant v5 ARCH_KIRKWOOD and v5 ARCH_MVEBU.

>  What i need to determine is if
> ARCH_KIRKWOOD and ARCH_MVEBU v5 will go into one binary. I _think_ the
> answer is no, but i need to take a closer look.

Arnd has said no too.

> What i suspect we will end up doing it dropping the last patch for the
> moment and ensuring ARCH_KIRKWOOD still supports all the DT machines.
> I think that just needs care with arch/arm/boot/dts/Makefile.
> 
> Once we have the last four converted over to DT, you can then do a
> straight swap, mach-kirkwood for mach-mvebu.

That sounds like a good plan, thanks!

If we are going to do a straight swap I suppose it might as go for a v5
multiplatform flavour instead of a mvebu specific one.

> I will get back to you in a couple of days once i have this all
> figured out.

Thank you.

Ian.
