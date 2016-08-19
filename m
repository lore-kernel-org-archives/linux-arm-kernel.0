From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 19 Aug 2016 11:22:52 +0530
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <3592cfe2-a563-7c26-9a9e-925051cc1934@codeaurora.org>
References: <20160804144003.GV1041@n2100.armlinux.org.uk>
 <cff588a1-d85f-3d2c-ef61-1674d0d3ca92@codeaurora.org>
 <20160808090203.GY9681@localhost>
 <21475c6e-a5f8-5125-3998-f3995ce67c4d@codeaurora.org>
 <20160810172805.GH9681@localhost>
 <d09ebb5f-99ea-a4e9-da9c-693be89c7cd4@codeaurora.org>
 <20160819024853.GR9681@localhost>
 <8c096fee-9749-a7df-7e04-25d21c0ea9ac@codeaurora.org>
 <20160819034249.GS9681@localhost>
 <3592cfe2-a563-7c26-9a9e-925051cc1934@codeaurora.org>
Message-ID: <20160819055252.GT9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 11:48:52PM -0400, Sinan Kaya wrote:
> On 8/18/2016 11:42 PM, Vinod Koul wrote:
> > On Thu, Aug 18, 2016 at 11:26:28PM -0400, Sinan Kaya wrote:
> >> On 8/18/2016 10:48 PM, Vinod Koul wrote:
> >>>> Keep a size limited list with error cookies and flush them in terminate all?
> >>> I think so, terminate_all anyway cleans up the channel. Btw what is the
> >>> behaviour on error? Do you terminate or somthing else?
> >>>
> >>
> >> On error, I flush all outstanding transactions with an error code and I reset
> >> the channel. After the reset, the DMA channel is functional again. The client
> >> doesn't need to shutdown anything.
> > 
> > You mean from the client context or driver?
> > 
> 
> The client doesn't need to call device_free_chan_resources and device_terminate_all
> to be specific. Client can certainly call these if it needs to but it is not
> required to recover the channel.

You didn't answer my question!

On error you said you flush, so who does that?

> After the reset in error condition, the client can continue issuing new requests
> with tx_submit and device_issue_pending as usual.

-- 
~Vinod
