From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 7 Oct 2015 15:32:06 +0100
Subject: [PATCH v5 06/10] dmaengine: add API for getting dma controller's
 quirk
In-Reply-To: <56139289.7000005@rock-chips.com>
References: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
 <1442188139-6017-1-git-send-email-shawn.lin@rock-chips.com>
 <20151005153746.GG13501@vkoul-mobl.iind.intel.com>
 <56139289.7000005@rock-chips.com>
Message-ID: <20151007143205.GG3320@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 05:21:13PM +0800, Shawn Lin wrote:

> >>+	int (*device_get_quirks)(struct dma_chan *chan);
> >
> >And why do we want to expose this to users? THis doesnt seem right!
> >
> 
> Basically I agree not to expose dma's quirk to slave controllers...But, the
> fact I mentioned on cover letter explain the reasons why I have to let slave
> controllers know that they are working with a broken dma. It's a dilemma
> that if we don't want that to be exposed(let slave controllers' driver get
> the info via a API), we have to add broken quirk for all of them ,here and
> there, which seems to be a disaster:(
> 
> I would appreciate it if you could give me some suggestions at your earliest
> convenience. :)
> 
> >A quirk may exists but should be handled inside the controller driver and do
> >appropriate action. You don't tell users or expect them to handle these
> >
I laready gave one re-read the above lines.

Anyway I went ahead and read the usage. You are setting the slave parameters
for this. I can see two ways:
1. Have the quirk to driver and based on quirk reset the slave settings when
they are set by client.
2. Put this in DT and set the dma properties based on these quirks and let
driver and cleint be agnostic to it

-- 
~Vinod
