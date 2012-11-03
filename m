From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Sat, 03 Nov 2012 09:31:04 +0100
Subject: [PATCH v2 2/2] ARM: OMAP: omap_device: Correct resource handling
 for DT boot
In-Reply-To: <1351596296-13825-3-git-send-email-peter.ujfalusi@ti.com>
References: <1351596296-13825-1-git-send-email-peter.ujfalusi@ti.com>
 <1351596296-13825-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <5094D648.80608@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2012 12:24 PM, Peter Ujfalusi wrote:
> When booting with DT the OF core can fill up the resources provided within
> the DT blob.
> The current way of handling the DT boot prevents us from removing hwmod data
> for platforms only suppose to boot with DT (OMAP5 for example) since we need
> to keep the whole hwmod database intact in order to have more resources in
> hwmod than in DT (to be able to append the DMA resource from hwmod).
>
> To fix this issue we just examine the OF provided resources:
> If we do not have resources we use hwmod to fill them.
> If we have resources we check if we already able to recive DMA resource, if
> no we only append the DMA resurce from hwmod to the OF provided ones.
>
> In this way we can start removing hwmod data for devices which have their
> resources correctly configured in DT without regressions.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>ke

Acked-by: Kevin Hilman <khilman@ti.com>

Benoit, feel free to take this one as well.

Kevin
