From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 Dec 2013 11:14:53 -0800
Subject: OMAP baseline test results for v3.13-rc1 (toolchain Debian
 4.7.2-5)
In-Reply-To: <20131209171618.GC11433@atomide.com>
References: <alpine.DEB.2.02.1311250731410.1364@utopia.booyaka.com>
 <alpine.DEB.2.02.1311251514330.1364@utopia.booyaka.com>
 <alpine.DEB.2.02.1312090936530.32309@utopia.booyaka.com>
 <20131209171618.GC11433@atomide.com>
Message-ID: <20131209191452.GA13171@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [131209 09:17]:
> * Paul Walmsley <paul@pwsan.com> [131209 01:55]:
> > On Mon, 25 Nov 2013, Paul Walmsley wrote:
> > 
> > > On Mon, 25 Nov 2013, Paul Walmsley wrote:
> > > 
> > > > Boot to userspace:
> > > >     FAIL ( 1/11): 37xxevm
> > > 
> > > So looks like this is due to the switchover to DT-based booting for 37xx 
> > > EVM.  Will plug that in here and re-test.
> > 
> > Here's the updated test report.  Looks like dynamic idle PM tests are 
> > failing on the 37xxevm now.
> 
> Off-idle and wake-up events work but need these two pending patches:
> 
> 1. [PATCH] of/platform: Fix no irq domain found errors when populating interrupts
>    http://lkml.org/lkml/2013/11/22/520

Oops, this is the wrong patch, it should be:

1. [PATCH] of/platform: Fix no irq domain found errors when populating interrupts
   http://lkml.org/lkml/2013/11/22/520
 
> 2. [PATCH] ARM: dts: Fix omap serial wake-up when booted with device tree
>    http://www.spinics.net/lists/devicetree/msg13374.html
> 
> Without the first one we get some nasty looking harmless warnings, so I've
> been holding off to merging #2 until #1 is fixed.
> 
> Regards,
> 
> Tony
