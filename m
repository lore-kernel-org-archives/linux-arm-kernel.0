From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 11 Nov 2015 16:25:27 +0530
Subject: [PATCH v9] dmaengine: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A4A4FA395@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1440432666-10310-1-git-send-email-appanad@xilinx.com>
 <20151005152628.GE13501@vkoul-mobl.iind.intel.com>
 <C246CAC1457055469EF09E3A7AC4E11A4A4EC2DE@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20151006074459.GA23420@vkoul-mobl.iind.intel.com>
 <C246CAC1457055469EF09E3A7AC4E11A4A4FA395@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20151111105527.GL25173@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 10:23:35AM +0000, Appana Durga Kedareswara Rao wrote:
> > > > Pls justify why we should have two drivers. Looking at code makes me think
> > > > otherwise
> > >
> > >
> > [pls wrap your messages within 80 chars, I have reflowed below]

And ignoring recommendations does not help!!


> > > I agree with you and even initially we had a common driver with the
> > > similar implementation as you were mentioning.  Later on, being soft IPs,
> > > new features were added and the IPs became diversified. As an example,
> > > this driver has a residue Calculation whereas the other driver (VDMA) is
> > > not applicable and the way interrupts are handled is completely different.
> > > Briefly, they are two complete different IPs with a different register set
> > > and descriptor format. Eventually, it became too complex To manage the
> > > common driver as the code became messy with lot of conditions around.
> > > Mainly the validation process is a big concern, as every change In the IP
> > > compels to test all the complete features of both IPs.  So, we got
> > > convinced to the approach of separating the drivers to overcome this and
> > > it comes with Few addition lines of common code.
> > 
> > No it is not that hard, bunch of people already do that.
> > 
> > You need is a smart probe or perhaps invoke IP specfic method to
> > initialize dma controller.
> > 
> > In above case no one forces you to register status callback for both, you
> > can do based on the controller probed...
> > 
> > I am sorry but validation is not a strong point here. I have a driver which
> > manages bunch of different generations. Reuse helps in having lesser code
> > and bug fixes across generations easily..
> > 
> > We cant have two drivers pretty much doing same thing in kernel
> > 
> > Please fix this and come back
> 
> Sorry for delayed response. I was out sick.
> I had internal discussions with my team. Both DMA's target for completely different use cases, have different register sets and different descriptor formats.  Interrupt processing is also different. Each of these IPs undergo frequent changes and enhancements. Having a single driver means for any small change in any of the IPs the testing has to happen across a whole lot of test cases which looks inefficient.
> Thinking futuristically where we don't know in which way the IP changes can happen, I feel it is always good to have separate drivers. We can't predict the HW changes and since the DMAs are targeted for different use cases, we may end up in tricky situations if we have a single driver.
> I do agree that code reuse is generally efficient. But for our case we are not dealing with generations of same IP, but completely different IPs. Though there are some similarities between them, I feel the differences are many.
> On v7 of this series, I had put the same observation to which you seem to have agreed. That is the reason I went ahead with other comments. At this point it is definitely really hard for me to merge.  

Lot of this is unreadable and I am not going to add effort on this

> However, if you still insist and see a lot of value in having a single driver, I will see what I can do. As I said, it will be some work and in long term it will be a maintenance issue for Xilinx and our customers.

Yes please, I know you will have arguments for it but we know reuse helps,
reduces bugs. Yes validation is increased but that is how drivers are
written and maintained, and pls automate that!

-- 
~Vinod
