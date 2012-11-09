From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 9 Nov 2012 14:57:18 +0000
Subject: [PATCH v2 2/5] ARM: kernel: add device tree init map function
In-Reply-To: <20121109144259.GB17405@mudshark.cambridge.arm.com>
References: <1352471654-20207-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1352471654-20207-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20121109144259.GB17405@mudshark.cambridge.arm.com>
Message-ID: <20121109145718.GB20298@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 02:42:59PM +0000, Will Deacon wrote:
> On Fri, Nov 09, 2012 at 02:34:11PM +0000, Lorenzo Pieralisi wrote:
> > When booting through a device tree, the kernel cpu logical id map can be
> > initialized using device tree data passed by FW or through an embedded blob.
> > 
> > This patch adds a function that parses device tree "cpu" nodes and
> > retrieves the corresponding CPUs hardware identifiers (MPIDR).
> > It sets the possible cpus and the cpu logical map values according to
> > the number of CPUs defined in the device tree and respective properties.
> > 
> > The device tree HW identifiers are considered valid if all CPU nodes contain
> > a "reg" property and the DT defines a CPU node that matches the MPIDR[23:0]
> > of the boot CPU.
> > 
> > The primary CPU is assigned cpu logical number 0 to keep the current convention
> > valid.
> > 
> > Current bindings documentation is included in the patch:
> > 
> > Documentation/devicetree/bindings/arm/cpus.txt
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> [...]
> 
> > +List of possible "compatible" string ids:
> > +
> > +<arm, arm1020>
> > +<arm, arm1020e>
> > +<arm, arm1022>
> > +<arm, arm1026>
> > +<arm, arm720>
> > +<arm, arm740>
> > +<arm, arm7tdmi>
> > +<arm, arm920>
> > +<arm, arm922>
> > +<arm, arm925>
> > +<arm, arm926>
> > +<arm, arm940>
> > +<arm, arm946>
> > +<arm, arm9tdmi>
> > +<arm, fa526>
> > +<arm, feroceon>
> > +<arm, mohawk>
> > +<arm, sa110>
> > +<arm, sa1100>
> > +<arm, xsc3>
> > +<arm, xscale>
> > +<arm, cortex-a5>
> > +<arm, cortex-a7>
> > +<arm, cortex-a8>
> > +<arm, cortex-a9>
> > +<arm, cortex-a15>
> > +<arm, arm1136>
> > +<arm, arm11-mpcore>
> 
> Is this supposed to be an exhaustive list? What about 1156 and 1176? Also,
> "arm11mpcore" should probably be used instead of "arm11-mpcore".

I added the list since IMHO defining a compatible property and not
defining a list of possible strings can encourage abuse. Happy to do
whatever DT guys think I should do with it.

I will add the processor version strings you suggested.

Thanks,
Lorenzo
