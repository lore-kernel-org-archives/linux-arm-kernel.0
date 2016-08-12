From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 12 Aug 2016 16:31:47 +0900
Subject: [PATCH 4/8] of: dma: Split of_configure_dma() into mask and ops
 configuration
In-Reply-To: <1470696550-3416-5-git-send-email-sricharan@codeaurora.org>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
 <1470696550-3416-5-git-send-email-sricharan@codeaurora.org>
Message-ID: <CAAFQd5BkpHrF=2=UXFA2mPKe0VQAD3J_XSNrZYHP0br5hw=Gsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 9, 2016 at 7:49 AM, Sricharan R <sricharan@codeaurora.org> wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> The of_configure_dma() function configures both the DMA masks and ops.
> Moving DMA ops configuration to probe time would thus also delay
> configuration of the DMA masks, which might not be safe. To avoid issues

Do we know any example cases when it might be unsafe? I think we kind
of rely on the fact that DMA mapping (and so DMA masks as well) is not
used before probing the device anyway, because we let the IOMMU
attachment happen at probe time, which essentially makes any earlier
attempts to use DMA mapping on such device incorrect.

Best regards,
Tomasz
