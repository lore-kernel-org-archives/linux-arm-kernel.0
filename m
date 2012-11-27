From: elen.song@atmel.com (Elen Song)
Date: Tue, 27 Nov 2012 10:39:46 +0800
Subject: [question] some question about the residue
In-Reply-To: <20121126104027.GD19440@n2100.arm.linux.org.uk>
References: <1353912197-16616-1-git-send-email-elen.song@atmel.com>
 <1353912597.7077.67.camel@vkoul-udesk3> <50B31BCE.6020100@atmel.com>
 <20121126102200.GB19440@n2100.arm.linux.org.uk> <50B34668.1090402@atmel.com>
 <20121126104027.GD19440@n2100.arm.linux.org.uk>
Message-ID: <50B427F2.30204@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-26 18:40, Russell King - ARM Linux wrote:
> On Mon, Nov 26, 2012 at 06:37:28PM +0800, Elen Song wrote:
>> So residue actually means current active descriptor remain, it should
> No, not the current active descriptor - the transfer identified by the
> cookie, and only that transfer.
Hi Russell King:

     Thank you for your explanations.
     Here I got an example, perhaps you can help me figure out if it is 
correct.

//allocate a cyclic transfer with 2 descriptors, a cookie identify 
current transfer.
desc = dmaengine_prep_dma_cyclic(chan,
                                 sg_dma_address,
                                 sg_dma_len,
                                 sg_dma_len/2,
                                 DMA_DEV_TO_MEM);
cookie= dmaengine_submit(desc);

//if transfer in progress, state.residue is current transfer 
remain(sg_dma_len remain), not current descriptor remain(sg_dma_len/2 
remain).
device_tx_status(chan,cookie, &state);

     Is it right?

Best Regards
