From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 27 Nov 2013 17:28:06 +0000
Subject: [RFC PATCH] Documentation: devicetree: add description for generic
 bus properties
Message-ID: <20131127172806.GC2291@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

SoC architectures are getting increasingly complex in ways that are not
transparent to software.

A particular emerging issue is that of multi-master SoCs, which may have
different address views, IOMMUs, and coherency behaviour from one master
to the next.

DT can't describe multi-master systems today except for PCI DMA and
similar.  This comes with constraints and assumptions that won't work
for emerging SoC bus architectures.  On-SoC, a device's interface to the
system can't be described in terms of a single interface to a single
"bus".

Different masters may have different views of the system too.  Software
needs to understand the true topology in order to do address mapping,
coherency management etc., in any generic way.

One piece of the puzzle is to define how to describe these topologies in
DT.

The other is how to get the right abstractions in the kernel to drive
these systems in a generic way.

The following proposal (originally from Will) begins to address the DT
part.

Comments encouraged -- I anticipate it may take some discussion to
reach a consensus here.

Cheers
---Dave
