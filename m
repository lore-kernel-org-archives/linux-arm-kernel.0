From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 9 Feb 2017 20:21:43 +0000
Subject: [PATCH 1/2] ARM: add ARM_SINGLE_ARMV7 as config option
In-Reply-To: <5d90aff5-63b7-83a8-7529-2ac61ef82021@gmail.com>
References: <20170209033044.19513-1-chris.brandt@renesas.com>
 <20170209033044.19513-2-chris.brandt@renesas.com>
 <519f1f67-5cfc-db78-c2b7-6bb74b78f3c8@gmail.com>
 <SG2PR06MB1165828CEDD6C06F6D1CBBF98A450@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <5d90aff5-63b7-83a8-7529-2ac61ef82021@gmail.com>
Message-ID: <SG2PR06MB11650C805DD754EE5C9E56C78A450@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 09, 2017, Florian Fainelli worte:
> > I think the closest I might have come was to purposely break the build
> > if more then 1 was select, but that still didn't stop you from making
> > the selection.
> >
> > If someone smarter than me has a way to do (not just an idea...I
> received
> > lots of ideas but none of them worked), I'd be happy to hear it.
> 
> I am definitively not a Kbuild expert, but it would almost necessarily
> require introduce some kind of new type in the Kconfig/Kbuild syntax
> that does something like that:
> 
> - have a way to count the number of symbols that are selected and do a
> "if ARCH_MULTI_V6_V7" (or an arbitrary expression) this most likely
> should exist internally within Kconfig
> 
> - introduce a new type of Kconfig type which is a "count", and gets
> assigned this value that we just counted, something that could look like
> this:
> 
> count ARCH_MULTI_V6_V7_COUNT
> 	tracks ARCH_MULTI_V6_V7

I did try the counting thing, but couldn't get it to work.
I admit though, I did stop when the next step was to create a new type
kind of thing that I could use for counting. That seemed to start going
down a deeper path than I was hoping for.

However,
I am hesitant to go and try anything else because everything I've submitted
so far has been NACKed. The only thing Russell said he'd agree to is a top
level single-platform option. But, since that all got taken out, I assume
there's some resistance to putting it back in.


Chris
