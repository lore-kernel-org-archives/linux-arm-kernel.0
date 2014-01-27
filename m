From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 27 Jan 2014 18:10:05 +0000
Subject: [PATCH RFC v2 1/2] Documentation: arm: add cache DT bindings
In-Reply-To: <20140127125839.GL15937@n2100.arm.linux.org.uk>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20140121114845.GA2598@e103592.cambridge.arm.com>
 <20140127125839.GL15937@n2100.arm.linux.org.uk>
Message-ID: <20140127181005.GA8367@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 12:58:39PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 21, 2014 at 11:49:01AM +0000, Dave Martin wrote:
> > I do have a worry that because the kernel won't normally use this
> > information, by default it will get pasted between .dts files, won't get
> > tested and will be wrong rather often.  It also violates the DT principle
> > that probeable information should not be present in the DT -- ePAPR
> > obviously envisages systems where cache geometry information is not
> > probeable, but that's not the case for architected caches on ARM, except
> > in rare cases where the CLIDR is wrong.
> 
> That statement is wrong.  There are caches on ARM CPUs where there is no
> CLIDR register.  I suggest reading the earlier DDI0100 revisions.

You are right, Dave was referring to the cache geometry properties in the
ePAPRv1.1, and the question on whether to ignore them for ARM. True, some
earlier ARM processors would need DT properties to define cache geometry owing
to the lack of cache type/id registers, but I guess we can work around that
and safely rule cache geometry properties out for ARM (better that than
having people rely on dts files containing wrong copy'n'pasted cache
geometry properties, that's the reasoning). The only reason we are defining
these bindings is to make sure we are able to detect which CPUs share what
caches, we can work around the lack of cache type/id registers to probe
geometry in earlier processors in the kernel.

Thanks,
Lorenzo
