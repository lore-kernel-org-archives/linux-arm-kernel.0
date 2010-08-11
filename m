From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Aug 2010 21:38:20 +0100
Subject: Memory type used for ioremap
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030E700CCF@dbde02.ent.ti.com>
References: <1278677464.11895.41.camel@e102109-lin.cambridge.arm.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E181CAD@dbde02.ent.ti.com>
	<20100709141416.GI22845@n2100.arm.linux.org.uk>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E5E42A7@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C641DE6B@dbde02.ent.ti.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E5E47F6@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C641E31D@dbde02.ent.ti.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E700C1E@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C65D750B@dbde02.ent.ti.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E700CCF@dbde02.ent.ti.com>
Message-ID: <20100811203820.GB463@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 08:28:00PM +0530, Pedanekar, Hemant wrote:
> Is this patch accepted or under review? I don't see it on omap yet.

It's not something that would be accepted as its a local debugging
measure only.

What you could do is setup a static mapping using MT_UNCACHED instead,
which is what IOP platforms do for their PCI registers which are
explicitly stated to be SO.
