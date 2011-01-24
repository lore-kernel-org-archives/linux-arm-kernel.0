From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 24 Jan 2011 12:27:16 -0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <alpine.LFD.2.00.1101211456200.8580@xanadu.home>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
	<alpine.LFD.2.00.1101211456200.8580@xanadu.home>
Message-ID: <000001cbbbc2$0e815e80$2b841b80$@moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Wouldn't the ultimate solution be to simply use FIQs to service the
> MMC FIFO?

The ultimate solution is to super-size FIFO ;-) It's not impossible (as the motherboard peripherals live in a FPGA), but according to our board people may be tricky due to the MMCI design (it's just ancient, that's all).

Now, the first thing I did was bumping the MMCI interrupts priorities, then I was considering use of FIQ. But - as Russell pointed out - it's simply not so simple...

> the secure world could provide some kind of 
> software based DMA engine facility to the non-secure world for this FIFO 
> servicing purpose.

It's very, very unrealistic to expect any secure stack implementation (say, Visa or MasterCard authorization software) to provide such feature for anyone.

So - we'll try to enlarge FIFO. For the moment - playing with interrupts affinity seem to be a viable workaround.

Cheers!

Pawe?
