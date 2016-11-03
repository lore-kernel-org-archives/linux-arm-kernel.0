From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 3 Nov 2016 09:26:08 +0100
Subject: [PATCH v2 04/14] ASoC: sun4i-codec: Increase DMA max burst to 8
In-Reply-To: <20161103075556.29018-5-wens@csie.org>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-5-wens@csie.org>
Message-ID: <20161103082608.4e27avywl5fmozt2@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 03:55:46PM +0800, Chen-Yu Tsai wrote:
> According to the DMA engine API documentation, maxburst denotes the
> largest possible size of a single transfer, so as not to overflow
> destination FIFOs as explained in this excerpt from dmaengine.h
> 
>  * @src_maxburst: the maximum number of words (note: words, as in
>  * units of the src_addr_width member, not bytes) that can be sent
>  * in one burst to the device. Typically something like half the
>  * FIFO depth on I/O peripherals so you don't overflow it. This
>  * may or may not be applicable on memory sources.
>  * @dst_maxburst: same as src_maxburst but for destination target
>  * mutatis mutandis.
> 
> The TX FIFO is 64 samples deep for stereo, and the RX FIFO is 16
> samples deep. So maxburst could be 32 and 8 for TX and RX respectively.
> 
> Unfortunately the sunxi DMA controller driver takes maxburst as
> the requested burst size, rather than a limit, and returns an error
> for unsupported values. The original value was 4, but some later
> SoCs do not officially support this burst size.
> 
> This patch increases maxburst on the TX side to 8, which is supported
> by all variants of the sunxi DMA controller.
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161103/7e1feb49/attachment.sig>
