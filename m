From: broonie@kernel.org (Mark Brown)
Date: Tue, 5 Jul 2016 16:55:56 +0200
Subject: [PATCH v2 5/5] spi: s3c64xx: use unsigned type for fifo handling
 variables
In-Reply-To: <1467081676-8442-6-git-send-email-andi.shyti@samsung.com>
References: <1467081676-8442-1-git-send-email-andi.shyti@samsung.com>
 <1467081676-8442-6-git-send-email-andi.shyti@samsung.com>
Message-ID: <20160705145556.GD6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 11:41:15AM +0900, Andi Shyti wrote:
> The 'quirks' variable cannot ever be negative, therefore use u8
> instead of int. The 8 bit size is given from the fact that
> currently the quirks variable has very few statuses.
> 
> The rx_lvl_offset and tx_st_done store shift values, so that u8
> is a proper size.
> 
> fifo_lvl_mask stores a series of masks, to be in we will keep the
> 32 bit size.

What's the advantage of these changes?  This feels like microptimisation
of something that shouldn't be a big performance issue and it's not
always the case that the compiler does something more sensible with
smaller or unsigned types.  I'm not saying don't do it, I'm just saying
that it's not clear to me what the win is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160705/f7e2e514/attachment.sig>
