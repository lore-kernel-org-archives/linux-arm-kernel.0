From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Nov 2017 09:27:46 -0600
Subject: [PATCH v3 1/4] dt-bindings: iio: at91-sama5d2_adc: add optional
 dma property
In-Reply-To: <1510750608-8697-2-git-send-email-eugen.hristev@microchip.com>
References: <1510750608-8697-1-git-send-email-eugen.hristev@microchip.com>
 <1510750608-8697-2-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20171115152746.w4giwt7kdqm4i3yl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 02:56:45PM +0200, Eugen Hristev wrote:
> Added property for DMA configuration of the device.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Changes in v3:
> None, but we discussed on the ML about whether we should have "dma-names"
> present in the binding even if it's only one.
> The helpers in the kernel to retrieve the channel info rely on the
> presence of this property, so I am resending the patch based on this.
> If another solution is better, please advise and I can try it and
> resend the patch.

Really the kernel APIs should accept a NULL name and return the DMA 
channel when there is only one. This is how the clk_get API works for 
example.

>  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

In any case, not really a big deal.

Acked-by: Rob Herring <robh@kernel.org>
