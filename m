From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 9 Feb 2017 03:50:55 +0000
Subject: [PATCH 1/2] ARM: add ARM_SINGLE_ARMV7 as config option
In-Reply-To: <519f1f67-5cfc-db78-c2b7-6bb74b78f3c8@gmail.com>
References: <20170209033044.19513-1-chris.brandt@renesas.com>
 <20170209033044.19513-2-chris.brandt@renesas.com>
 <519f1f67-5cfc-db78-c2b7-6bb74b78f3c8@gmail.com>
Message-ID: <SG2PR06MB1165828CEDD6C06F6D1CBBF98A450@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Florian,

On Wednesday, February 08, 2017, Florian Fainelli wrote:
> On 02/08/2017 07:30 PM, Chris Brandt wrote:
> > Creates a new ARM_SINGLE_ARMV7 option as an alternative
> ARCH_MULTIPLATFORM.
> >
> > ARM_SINGLE_ARMV7 is very similar to ARCH_MULTIPLATFORM, except the
> > options from ARCH_MULTI_V6_V7 were copied directly into the new
> ARM_SINGLE_ARMV7.
> >
> > Additionally, everywhere ARCH_MULTIPLATFORM existed in build scripts,
> > ARM_SINGLE_ARMV7 was added along side it in order to produce similar
> > results.
> 
> Could we try to be a little smarter than this and if ARCH_MULTIPLATFORM is
> selected but only one platform beneath is we automatically select
> ARM_SINGLE_ARMV7 (this may require Kconfig hackery)?

Months ago I spent hours on trying to get the current kbuild system to do
that and nothing I came up with would work. It's simply not designed that
way.

I think the closest I might have come was to purposely break the build
if more then 1 was select, but that still didn't stop you from making
the selection.

If someone smarter than me has a way to do (not just an idea...I received
lots of ideas but none of them worked), I'd be happy to hear it.



> I see value in what you are doing, but I don't think pulling the platforms
> out of the menu like what you do in the subsequent patch is looking nice
> as an user/configurator.

What I was trying to do (and what was already removed from Kconfigs) was
to avoid having a duplicate set of configs for each SOC: one for single and
one for multi.


#I'm trying to get away from manually hacking these Kconfig files every time
a new kernel is released.


Chris
