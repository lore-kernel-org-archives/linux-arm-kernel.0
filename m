From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 08:45:33 +0900
Subject: [PATCH] ARM: shmobile: set proper DMA masks for Ether devices
In-Reply-To: <52FB5BD0.10707@cogentembedded.com>
References: <201402120255.25037.sergei.shtylyov@cogentembedded.com>
 <20140212013517.GE17104@verge.net.au>
 <52FB5BD0.10707@cogentembedded.com>
Message-ID: <20140212234533.GA28472@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 03:32:32PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 12-02-2014 5:35, Simon Horman wrote:
> 
> >>Ether MAC is a DMA-capable device and so should have 'dev.dma_mask' and
> >>'dev.coherent_dma_mask' fields set properly, to reflect 32-bit DMA addressing
> >>ability.  Currently, the code works without DMA masks but in the future, when
> >>support for NETIF_F_HIGHDMA & NETIF_F_SG would be added to the 'sh_eth' driver,
> >>the DMA masks should start to matter...
> 
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >Hi Sergei,
> 
> >please split this series up so there is a separate patch for each board.
> 
>    Hm, I, contrariwise, gathered all board patches in the single
> patch. Could you elaborate on why you deem it necessary to split it?

In my experience it helps to have the patches split out for two reasons:
1. If there is a problem on one board its patch can be reverted without
   having to bother with making a partial revert in order to leave the
   other boards alone.
2. It makes backporting easier in the case where there is interest in
   one board but not another.

Moreover, the boards are separate entities and in general I would
like their patches to be separate. The same goes for SoCs.

I realise this is more fine-grained than what other maintainers prefer
but it is an approach that seems to work well for us.
