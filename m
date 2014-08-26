From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 26 Aug 2014 12:52:16 +0300
Subject: [PATCH v2] video: ARM CLCD: Fix calculation of bits-per-pixel
In-Reply-To: <1408538464.3858.43.camel@linaro1.home>
References: <1408538464.3858.43.camel@linaro1.home>
Message-ID: <53FC58D0.6080700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/08/14 15:41, Jon Medhurst (Tixy) wrote:
> If the device-tree specifies a max-memory-bandwidth property then the
> CLCD driver uses that to calculate the bits-per-pixel supported,
> however, this calculation is faulty for two reasons.
> 
> 1. It doesn't ensure that the result is a sane value, i.e. a power of 2
>    and <= 32 as the rest of the code assumes.
> 
> 2. It uses the displayed resolution and calculates the average bandwidth
>    across the whole frame. It should instead calculate the peak
>    bandwidth based on the pixel clock.
> 
> This patch fixes both the above.
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>

Thanks, queued for 3.17 fbdev fixes.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/0523d2cc/attachment-0001.sig>
