From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 24 Sep 2010 16:42:49 +0200
Subject: [RFC] SoC name and revision in /proc/cpuinfo
In-Reply-To: <20100924140652.GA14809@n2100.arm.linux.org.uk>
References: <20100924135356.GA17651@game.jcrosoft.org>
	<20100924140652.GA14809@n2100.arm.linux.org.uk>
Message-ID: <20100924144249.GB17651@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:06 Fri 24 Sep     , Russell King - ARM Linux wrote:
> On Fri, Sep 24, 2010 at 03:53:56PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > Hi Russell,
> > 
> > 	On AT91 for some userland library we need to known the cpu model and revision
> > 	so I'd like to known if it's ok with you to extend it?
> > 
> > 	as
> > 	cpu familly:	at91
> > 	cpu type:	at91sam9g20
> > 	cpu revision:	1.1
> 
> You're mixing up the CPU with the SoC.  The CPU is what's in the core of
> the SoC and has no peripherals etc.  The SoC is the entire chip.  "Central
> Processing Unit."  "System on a Chip."
> 
> I'd much rather see SoC information kept separate from the CPU information.
I knwon the diff between cpu and soc but today others arch do this the same way
via cpuinfo as example sh or others.

So what do you propose?

is this better

soc familly:	at91
soc type:	at91am9g20
soc revision:	1.1

or you will prefer we create a new entry like sysinfo?

because today we store the hardware name, revision abd serial in cpuinfo
also

Best Regards,
J.
