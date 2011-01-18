From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jan 2011 22:41:04 +0000
Subject: [PATCH] drivers: mmc: msm: update to new arm pfn_to_dma API
In-Reply-To: <1295386138.26904.70.camel@c-dwalke-linux.qualcomm.com>
References: <1295373844-27713-1-git-send-email-dwalker@codeaurora.org>
	<20110118182826.GI16980@n2100.arm.linux.org.uk>
	<1295382134.26904.7.camel@c-dwalke-linux.qualcomm.com>
	<20110118204446.GL16980@n2100.arm.linux.org.uk>
	<1295384420.26904.56.camel@c-dwalke-linux.qualcomm.com>
	<20110118211606.GM16980@n2100.arm.linux.org.uk>
	<1295386138.26904.70.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20110118224104.GN16980@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 01:28:58PM -0800, Daniel Walker wrote:
> On Tue, 2011-01-18 at 21:16 +0000, Russell King - ARM Linux wrote:
> > On Tue, Jan 18, 2011 at 01:00:20PM -0800, Daniel Walker wrote:
> > > Just greping the driver I found at least one writel() .. I'm not really
> > > concerned with that tho. I use this driver, I need this driver to work.
> > > You broke the driver, and your NAK'ing the fix ..
> > 
> > If drivers use documented internal APIs, they _will_ break, and that's
> > tough luck.  The advertised API (DMA-mapping) is what we guarantee to
> > support and fixup drivers for.
> 
> I don't think that's a good policy. There could be reasons why a driver
> might use an internal API .. Breaking the build is worse, to me, than
> using an internal API.

If things use the wrong APIs they get broken, plain and simple.  It
happens, and we cope with it and fix it properly when it happens,
rather than subsituting the wrong way for another wrong way.

> Did you give us a fix for this issue? That's what I was asking in the
> last email cause it didn't appear like you touched that area.

I gave you an example of how to fix the problem you reported - what
more do you want?
