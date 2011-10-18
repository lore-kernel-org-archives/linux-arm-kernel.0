From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Oct 2011 11:18:53 +0100
Subject: [PATCH 3/9] ARM: SPMP8000: Add clk support
In-Reply-To: <20111017121548.GH5448@sirena.org.uk>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-4-git-send-email-zoss@devai.org>
	<20111013093836.GK21648@n2100.arm.linux.org.uk>
	<CAGVye5Oy8M3+PBZN2KXMmnstBtxngb0feYELgbnu5ZWxZBHLEw@mail.gmail.com>
	<20111017121548.GH5448@sirena.org.uk>
Message-ID: <20111018101853.GM21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2011 at 01:15:48PM +0100, Mark Brown wrote:
> On Sun, Oct 16, 2011 at 04:16:45PM +0200, Zoltan Devai wrote:
> > 2011/10/13 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > > I find the use of 'scu' for something which isn't the SMP Coherence Unit

Sorry, that should've been 'snoop control unit' to give its proper
terminology.

> > > rather confusing - and I suspect you will too if/when spmp8000 has SMP
> > > support.
> 
> > Well, Sunplus decided to name these devices 'SCU', which are a collection
> > of reset, clock, debug, pinmux and gpio stuff.
> > The datasheet doesn't even tell what SCU stands for, but I'd prefer to keep
> > the naming to be in sync with the documentation.
> 
> System Control Unit.  It's a fairly common name to use for the core
> system glue logic.

So, what do we do about this confusing overloading of a TLA ?  It's
already had me searching through these patches for some reference
to SMP stuff and wondering if its differing SMP implementation.
