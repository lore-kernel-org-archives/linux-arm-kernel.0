From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 22 Jul 2016 10:59:29 +0200
Subject: [PATCH 1/3] mmc: sunxi-mmc: change idma descriptor to __le32
In-Reply-To: <20160721182329.13478-2-michael.weiser@gmx.de>
References: <20160721182329.13478-1-michael.weiser@gmx.de>
 <20160721182329.13478-2-michael.weiser@gmx.de>
Message-ID: <20160722085929.GA7687@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 08:23:27PM +0200, Michael Weiser wrote:
> The sunxi-mmc driver does not take into account the processor may be big
> endian when writing the DMA descriptors. This causes cards not to be
> detected when running a big-endian kernel. Change the descriptors for
> IDMA to use __le32 and ensure they are suitably swapped before writing.
> Tested successfully on the Cubieboard2.
> 
> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-mmc at vger.kernel.org

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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160722/f4b399ca/attachment.sig>
