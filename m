From: horms@verge.net.au (Simon Horman)
Date: Tue, 18 Apr 2017 16:30:42 +0900
Subject: [PATCH/RFT] sata: rcar_sata: Reset SATA PHY on resume
In-Reply-To: <20170418071738.GD3899@wtj.duckdns.org>
References: <1492498973-2969-1-git-send-email-horms+renesas@verge.net.au>
 <20170418071738.GD3899@wtj.duckdns.org>
Message-ID: <20170418073042.GB16340@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 04:17:38PM +0900, Tejun Heo wrote:
> On Tue, Apr 18, 2017 at 04:02:53PM +0900, Simon Horman wrote:
> > In the case where power is cut on suspend the SATA PHY state needs to be
> > suspended on resume.
>   ^
>   re-initialized?

Yes, sorry for the think-o.

> > This is the case on the Salvator-X board with the r8a7795 or r8a7796 SoC.
> > In that environment it has been observed that SATA partitions cannot not be
> > accessed on resume.
> > 
> > Based on work by Khiem Nguyen.
> > 
> > Cc: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > * Compile and boot tested only
> 
> Can somebody verify this fix?

Yes, I should be able to do so but I need to set up the appropriate
hardware environment first. I would, of course, welcome verification by
others.
