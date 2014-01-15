From: ijc@hellion.org.uk (Ian Campbell)
Date: Wed, 15 Jan 2014 09:26:12 +0000
Subject: v3.12 regression from "ARM: kirkwood: convert to DT irqchip and
 clocksource" on non-DT kirkwood platforms
In-Reply-To: <52D651CD.5020307@gmail.com>
References: <1389775235.10695.51.camel@dagon.hellion.org.uk>
 <52D651CD.5020307@gmail.com>
Message-ID: <1389777972.12434.115.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-01-15 at 10:15 +0100, Sebastian Hesselbarth wrote:
> On 01/15/14 09:40, Ian Campbell wrote:
> > The bootlogs are below or in the bug. It stops after "Console: colour
> > dummy device 80x30", I think next would normally be the
> > BogoMIPS/calibrate_delay output.
> 
> That would indicate the timer (clocksource) or irq (irqchip) is not
> running correctly. Again, that could be non-DT and DT fighting for it.
> I'll investigate that.

That seems logical.

> In the meantime, can you recompile your kernel and set
> CONFIG_ARCH_KIRKWOOD_DT=n ?

I can confirm that v3.13-rc8 with CONFIG_ARCH_KIRKWOOD_DT=n works.

Thanks,
Ian.
