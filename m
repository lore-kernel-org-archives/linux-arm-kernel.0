From: svenkatr@ti.com (S, Venkatraman)
Date: Fri, 21 Sep 2012 22:45:29 +0530
Subject: [RFC PATCH 08/13] mmc: omap_hsmmc: limit max_segs with the EDMA
 DMAC
In-Reply-To: <1348152226-13588-9-git-send-email-mporter@ti.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-9-git-send-email-mporter@ti.com>
Message-ID: <CANfBPZ81anOy8fWgKM1PgCtB4V2pEp2x1Qi4x1uPsq7QieMN5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 8:13 PM, Matt Porter <mporter@ti.com> wrote:
> The EDMA DMAC has a hardware limitation that prevents supporting
> scatter gather lists with any number of segments. Since the EDMA
> DMA Engine driver sets the maximum segments to 16, we do the
> same.
>
> Note: this can be removed once the DMA Engine API supports an
> API to query the DMAC's segment limitations.
>

I wouldn't want to bind the properties of EDMA to omap_hsmmc as this patch
suggests. Why don't we have a max_segs property, which when explicitly specified
in DT, will override the default ?
