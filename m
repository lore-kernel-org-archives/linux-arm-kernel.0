From: ynvich@gmail.com (Sergei Ianovich)
Date: Thu, 19 Dec 2013 04:50:41 +0400
Subject: [PATCH v3 07/21] ARM: dts: parse DMA config in pxamci
In-Reply-To: <1387309071-22382-8-git-send-email-ynvich@gmail.com>
References: <1386901645-28895-1-git-send-email-ynvich@gmail.com>
 <1387309071-22382-1-git-send-email-ynvich@gmail.com>
 <1387309071-22382-8-git-send-email-ynvich@gmail.com>
Message-ID: <1387414241.31516.19.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

On Tue, 2013-12-17 at 23:37 +0400, Sergei Ianovich wrote:
> The existing PXA MMC driver cannot get DMA channels in a proper
> way from the respective device tree binding.
> 
> This patch provides temporary workaround which allows using the
> existing driver in DT machines by pointing to the proper
> dmaengine-based "marvell,pdma-1.0" DMA.
> 
> Even though the new DMA provider is not present we can parse device node
> attributes manually and use channel numbers to acquire DMA channel
> from the existing non-dmaengine provider.
> 
> When Daniel's DMA series is merged there will be no need to manually
> parse for "dmas" and this patch can be safely reverted.
> 
> Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> CC: Daniel Mack <zonque@gmail.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> ---
>    v2..v3
>    * split into good (PATCH 07/21) and temporary (this one) parts
> 
>    v1..v2
>    * add binding for next-gen dma controller
>    * use correct dma declararion
>    * number changed from 5 to 3

Could you please comment on this solution for PXA DMA?

There may appear new, but it remains the last open review comment for
the series at the moment.
