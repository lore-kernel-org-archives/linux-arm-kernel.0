From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Nov 2009 23:22:21 +0100
Subject: IXP4xx: unneeded #include platform-specific include files?
In-Reply-To: <op.u3j7xuh92s3iss@richese> (Imre Kaloz's message of "Tue, 17 Nov
	2009 23:11:44 +0100")
References: <m3fx8fso72.fsf@intrepid.localdomain>
	<19200.18453.644399.845601@pilspetsen.it.uu.se>
	<op.u3gddjdi2s3iss@ecaz> <m3y6m7qylr.fsf@intrepid.localdomain>
	<op.u3j6cak02s3iss@richese> <m3ws1o4y3h.fsf@intrepid.localdomain>
	<op.u3j7xuh92s3iss@richese>
Message-ID: <m3skcc4wrm.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Imre Kaloz" <kaloz@openwrt.org> writes:

> Why wouldn't you want to remember that "INTA" was "GPIO8"? When you want to
> touch those lines you do have to remember or look up what GPIO was that one.
> So this hardly makes it easier to work with or to remember to -- it certainly
> duplicates the assignments, as you've also noted.

Actually I'm not sure if I understand you correctly.

If I use GPIO8 (presumably in different places) I have to remember what
it is. This may be use with a couple of IRQ lines but gets harder and
harder with a more complicated machine. Macros like SLOT0_INTA etc.
don't have this problem. That's BTW why macros and symbolic names were
invented.

> The INTx naming convention is also stupid, as in most cases these are
> not different
> INT lines of the PCI slot but either separate slots or subdevices -- and note,
> most of the boards only have INTa connected mechanically.
>
> And I didn't even get to the topic of *_PCI_MAX_DEV, *_PCI_IRQ_LINES
> and the mania
> of pci_irq_table usage..

But you've seen the patches I just posted, haven't you?
-- 
Krzysztof Halasa
