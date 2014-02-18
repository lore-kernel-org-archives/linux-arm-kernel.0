From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 18 Feb 2014 14:15:37 -0700
Subject: [PATCH] PCI: imx6: Fix link_up detection
In-Reply-To: <52FE6DA7.1010305@boundarydevices.com>
References: <1392190075-23204-1-git-send-email-s.hauer@pengutronix.de>
 <201402120836.16221.marex@denx.de>
 <52FD0F1A.4000208@boundarydevices.com>
 <20140214064153.GE17250@pengutronix.de>
 <52FE6DA7.1010305@boundarydevices.com>
Message-ID: <20140218211537.GC8786@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 12:25:27PM -0700, Troy Kisky wrote:
> On 2/13/2014 11:41 PM, Sascha Hauer wrote:
> > On Thu, Feb 13, 2014 at 11:29:46AM -0700, Troy Kisky wrote:
> >> On 2/12/2014 12:36 AM, Marek Vasut wrote:
> >>> On Wednesday, February 12, 2014 at 08:27:55 AM, Sascha Hauer wrote:
> >>>
> >>> +CC Troy Kisky, since I think he submitted something similar some time ago
> >>> already.
> >>>
> >>> Otherwise I agree this happens.
> >>>
> >> Sorry, I haven't submitted this yet, but was planning to today. Here's
> >> what would have been sent.
> >>
> >> From 32c560d33fe2c3945d69f3396689f0abb76f7e1f Mon Sep 17 00:00:00 2001
> >> From: Marek Vasut <marex@denx.de>
> >> Date: Sat, 25 Jan 2014 14:22:48 -0700
> >> Subject: [PATCH 1/1] pci-imx6.c: wait for retraining
> >>
> >> This patch handles the case where the PCIe link is up and running, yet drops
> >> into the LTSSM training mode. The link spends short time in the LTSSM training
> >> mode, but the current code can misinterpret it as the link being stalled.
> >> Waiting for the LTSSM training to complete fixes the issue.
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> Tested-by: Troy Kisky <troy.kisky@boundarydevices.com>
> > 
> > Thanks, that works.
> > 
> > Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > Sascha
> 
> I don't want to step on your toes, does that means you
> expect me to send a formal patch ?

I don't care which way we go, but we should make progress on this.

It looks like Troy's patch is slightly more extensive (adds comments, uses
actual times instead of a CPU speed-dependent wait loop, prints registers
for analysis in failure case), so based on that, I would go that route.

But we need an ack from Richard or Shawn anyway, so I'll just wait for
direction from them.

Bjorn
