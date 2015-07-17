From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 17 Jul 2015 08:22:20 +0200
Subject: [PATCH 0/2] dmaengine: Add scatter-gathered memset support
In-Reply-To: <1436177964-19380-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1436177964-19380-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150717062220.GH14886@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 06, 2015 at 12:19:22PM +0200, Maxime Ripard wrote:
> Hi Vinod,
> 
> Here is a patch serie that adds a new dmaengine operation for
> scatter-gathered memset.
> 
> Indeed, doing a memset over a discontiguous buffer is quite
> inefficient at the moment, since you have to create and submit each
> chunk separately, which might result in a huge list of transfers,
> while some controllers can handle that just fine.
> 
> Let me know what you think,
> Maxime
> 
> Maxime Ripard (2):
>   dmaengine: Add scatter-gathered memset
>   dmaengine: xdmac: Add scatter gathered memset support
> 

I have forgotten to add it but of course:

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks

>  drivers/dma/at_xdmac.c    | 166 +++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/dmaengine.h |   5 ++
>  2 files changed, 170 insertions(+), 1 deletion(-)
> 
> -- 
> 2.4.5
> 
