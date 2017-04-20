From: horms@verge.net.au (Simon Horman)
Date: Thu, 20 Apr 2017 18:05:37 +0900
Subject: [PATCH/RFT] sata: rcar_sata: Reset SATA PHY on resume
In-Reply-To: <308de569-b3a7-8909-c07c-6d39cab5b287@cogentembedded.com>
References: <1492498973-2969-1-git-send-email-horms+renesas@verge.net.au>
 <308de569-b3a7-8909-c07c-6d39cab5b287@cogentembedded.com>
Message-ID: <20170420090537.GJ3760@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 12:20:20PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 4/18/2017 10:02 AM, Simon Horman wrote:
> 
> >In the case where power is cut on suspend the SATA PHY state needs to be
> >suspended on resume.
> >
> >This is the case on the Salvator-X board with the r8a7795 or r8a7796 SoC.
> >In that environment it has been observed that SATA partitions cannot not be
> >accessed on resume.
> >
> >Based on work by Khiem Nguyen.
> >
> >Cc: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >* Compile and boot tested only
> >---
> > drivers/ata/sata_rcar.c | 9 +--------
> > 1 file changed, 1 insertion(+), 8 deletions(-)
> 
>    Why the scope prefix in the subject is not just "sata_rcar: "? :-)

Thanks, I will drop that.
