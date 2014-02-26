From: agross@codeaurora.org (Andy Gross)
Date: Wed, 26 Feb 2014 11:06:56 -0600
Subject: [Patch v7 2/2] dmaengine: add Qualcomm BAM dma driver
In-Reply-To: <530E1BAB.6040609@mm-sol.com>
References: <1393283500-18599-1-git-send-email-agross@codeaurora.org>
 <1393283500-18599-3-git-send-email-agross@codeaurora.org>
 <530E1BAB.6040609@mm-sol.com>
Message-ID: <20140226170656.GA21772@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 06:51:55PM +0200, Stanimir Varbanov wrote:
> > +	/* read revision and configuration information */
> > +	val = readl_relaxed(bdev->regs + BAM_REVISION) & NUM_EES_MASK;
> > +
> 
> The ees shit is not zero and you got wrong ee. Could you add the line
> below or something similar:
> 
> val = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
> 

Good catch.  I missed the shift when I reworked and got lucky that the revision
is in the lower 8 bits and is non-zero.

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
