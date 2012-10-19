From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Fri, 19 Oct 2012 12:02:42 +0000
Subject: [RFC PATCH v3 00/16] DMA Engine support for AM33XX
In-Reply-To: <20121019111558.GD25164@beef>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EBD29FC@DBDE01.ent.ti.com>
 <20121019111558.GD25164@beef>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBD2CE1@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 16:45:58, Porter, Matt wrote:
> On Fri, Oct 19, 2012 at 10:26:20AM +0000, Bedia, Vaibhav wrote:
[...]
> > 
> > I didn't see all the patches that you posted on edma-dmaengine-v3
> > but I do seem them on edma-dmaengine-am33xx-v3 branch.
> 
> I see I referenced the wrong branch in the cover letter. Thanks for
> testing and noticing this. Sorry to make you hunt for the correct
> branch in that repo. ;) 
> 

No problem.

> https://github.com/ohporter/linux/tree/edma-dmaengine-am33xx-v3
> is indeed the correct branch for those wanting to pull this in or
> grab some of the not-to-be-merged drivers I used for testing.
> 
> > I added a couple of patches to enable earlyprintk and build the DTB
> > appended kernel image uImage-dtb.am335x-evm
> > 
> > Here's what i see
> > 
> > [...]
> 
> <snip>
> 
> > [    0.175354] edma: probe of 49000000.edma failed with error -16
> 
> I missed an uninitialized pdata case in the bug fixes mentioned in
> the changelog and the folks previously failing the same way didn't
> hit the case I suspect you are hitting. Can you try this and let me
> know how it works?
> 

That doesn't help :(

Looking at the original crash log, I suspect something is not correct
with the irq portion, probably in the DT or the driver. 

"genirq: Flags mismatch irq 28. 00000000 (edma) vs. 00000000 (edma)"

The warning below that is coming due to fail case in edma_probe not tracking
the request_irq status properly and but IMO that's a separate issue.

BTW, I am trying this on the EVM.

Regards,
Vaibhav
