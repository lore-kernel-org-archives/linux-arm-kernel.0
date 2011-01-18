From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 18 Jan 2011 12:22:14 -0800
Subject: [PATCH] drivers: mmc: msm: update to new arm pfn_to_dma API
In-Reply-To: <20110118182826.GI16980@n2100.arm.linux.org.uk>
References: <1295373844-27713-1-git-send-email-dwalker@codeaurora.org>
	<20110118182826.GI16980@n2100.arm.linux.org.uk>
Message-ID: <1295382134.26904.7.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-01-18 at 18:28 +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 18, 2011 at 10:04:04AM -0800, Daniel Walker wrote:
> > The page_to_dma() API call was removed. It caused this build
> > failure,
> 
> Because it's an API internal interface.  Don't use it.  Why is this
> driver poking about in API internals all over the place?

If it's internal why is this driver able to call it?

> That is completely broken.  Please use the official APIs - it's not
> hard.  Here's how to do it correctly:

Can you make this into a patch and send it to David Brown ?

> 
> and when you use writel() etc afterwards, those non-cacheable writes to
> box-> will be ordered with your device write.
> 
> So that's a NAK for your original patch.

Are you given us alternative to my fix yet? I didn't see any of your
comments touching that area?

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
