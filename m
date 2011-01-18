From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 18 Jan 2011 13:28:58 -0800
Subject: [PATCH] drivers: mmc: msm: update to new arm pfn_to_dma API
In-Reply-To: <20110118211606.GM16980@n2100.arm.linux.org.uk>
References: <1295373844-27713-1-git-send-email-dwalker@codeaurora.org>
	<20110118182826.GI16980@n2100.arm.linux.org.uk>
	<1295382134.26904.7.camel@c-dwalke-linux.qualcomm.com>
	<20110118204446.GL16980@n2100.arm.linux.org.uk>
	<1295384420.26904.56.camel@c-dwalke-linux.qualcomm.com>
	<20110118211606.GM16980@n2100.arm.linux.org.uk>
Message-ID: <1295386138.26904.70.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-01-18 at 21:16 +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 18, 2011 at 01:00:20PM -0800, Daniel Walker wrote:
> > Just greping the driver I found at least one writel() .. I'm not really
> > concerned with that tho. I use this driver, I need this driver to work.
> > You broke the driver, and your NAK'ing the fix ..
> 
> If drivers use documented internal APIs, they _will_ break, and that's
> tough luck.  The advertised API (DMA-mapping) is what we guarantee to
> support and fixup drivers for.

I don't think that's a good policy. There could be reasons why a driver
might use an internal API .. Breaking the build is worse, to me, than
using an internal API.

> If you don't know that a driver is using an internal API then you can't
> preempt it breaking.  The answer is drivers must not use internal APIs.

At least you need to be receptive to fixes ..

> Had the driver been properly reviewed before being merged, it should
> have been caught before it was merged.

I didn't merge it, so I don't know how it was merged .. Bottom line is
it's a stable kernel driver.

> I've given you the outline of a proper fix, and you've probably already
> spent longer discussing it than it would take you to cut'n'paste the
> code into kernel and test it...

Did you give us a fix for this issue? That's what I was asking in the
last email cause it didn't appear like you touched that area.

Daniel


-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
