From: ralf@linux-mips.org (Ralf Baechle)
Date: Tue, 19 Jul 2011 11:34:27 +0100
Subject: [PATCH v2 1/2] irq: add irq_domain translation infrastructure
In-Reply-To: <20110718223140.1911.80783.stgit@ponder>
References: <20110718222610.1911.5673.stgit@ponder>
	<20110718223140.1911.80783.stgit@ponder>
Message-ID: <20110719103426.GA31394@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2011 at 04:31:40PM -0600, Grant Likely wrote:

> This patch adds irq_domain infrastructure for translating from
> hardware irq numbers to linux irqs.  This is particularly important
> for architectures adding device tree support because the current
> implementation (excluding PowerPC and SPARC) cannot handle
> translation for more than a single interrupt controller.  irq_domain
> supports device tree translation for any number of interrupt
> controllers.
> 
> This patch converts x86, Microblaze, ARM and MIPS to use irq_domain
> for device tree irq translation.  x86 is untested beyond compiling it,
> irq_domain is enabled for MIPS and Microblaze, but the old behaviour is
> preserved until the core code is modified to actually register an
> irq_domain yet.  On ARM it works and is required for much of the new
> ARM device tree board support.
> 
> PowerPC has /not/ been converted to use this new infrastructure.  It
> is still missing some features before it can replace the virq
> infrastructure already in powerpc (see documentation on
> irq_domain_map/unmap for details).  Followup patches will add the
> missing pieces and migrate PowerPC to use irq_domain.
> 
> SPARC has its own method of managing interrupts from the device tree
> and is unaffected by this change.

I like it - yet another building block of the conversion of MIPS to DT in
place.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks,

  Ralf
