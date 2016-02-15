From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Mon, 15 Feb 2016 16:34:39 +0100
Subject: [RFC PATCH 1/7] arm64/perf: Basic uncore counter support for
 Cavium ThunderX
In-Reply-To: <20160215142726.GD9732@leverpostej>
References: <cover.1455295032.git.jglauber@cavium.com>
 <8bd93a25e069ed6428bc6c21fc53270962ccafcc.1455295032.git.jglauber@cavium.com>
 <20160212173658.GD20262@leverpostej>
 <20160215140720.GA4053@hardcore>
 <20160215142726.GD9732@leverpostej>
Message-ID: <20160215153439.GA2586@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 02:27:27PM +0000, Mark Rutland wrote:
> > > > 1) The PMU detection solely relies on PCI device detection. If a
> > > >    matching PCI device is found the PMU is created. The code can deal
> > > >    with multiple units of the same type, e.g. more than one memory
> > > >    controller.
> > > 
> > > I see below that the driver has an initcall that runs regardless of
> > > whether the PCI device exists, and looks at the MIDR. That's clearly not
> > > string PCI device detection.
> > > 
> > > Why is this not a true PCI driver that only gets probed if the PCI
> > > device exists? 
> > 
> > It is not a PCI driver because there are already drivers like edac that
> > will access these PCI devices. The uncore driver only accesses the
> > performance counters, which are not used by the other drivers.
> 
> Several drivers are accessing the same device?
> 
> That sounds somewhat scary.

I've double checked that the edac drivers do not access the performance
counters at all. It felt cleaner to me to keep the performance counter code
seperated from edac.

Jan
