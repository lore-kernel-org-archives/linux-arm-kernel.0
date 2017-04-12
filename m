From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 12 Apr 2017 23:48:16 +1000
Subject: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
In-Reply-To: <20170412094454.GA31143@red-moon>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <1491917906.7236.7.camel@kernel.crashing.org>
 <20170411140857.GA6821@red-moon>
 <1491952371.7236.22.camel@kernel.crashing.org>
 <20170412094454.GA31143@red-moon>
Message-ID: <1492004896.7236.59.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-04-12 at 10:44 +0100, Lorenzo Pieralisi wrote:
> > This is a problem to be solved by the bridge itself. If ARM has a
> > mapping attribute to make stores non-posted, keep this an ARM specific
> > attribute at this stage I'd say.
> 
> I can't. Some PCI host bridge drivers (DT) are shared between ARM/ARM64
> and live in drivers (and are also reused on some arches eg microblaze)
> and they use ioremap() to map config space.
> 
> So the idea behind this series was to add an interface (that is
> overriden on ARM/ARM64), it started as a PCI specific interface (v1) and
> evolved to ioremap_nopost() (v2).

Then provide some kind of HAVE_* or config option indicating that this
mapping attribute exist so the bridge code at least has the option of
implementing an "alternative" mechanism when it doesn't rather than
silently being wrong :-)

(Or just return NULL, that works too)

Cheers,
Ben.
