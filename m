From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Apr 2014 00:10:12 +0100
Subject: Rockchip RK3188 I2C driver
In-Reply-To: <1917043.Q4CxE5T68K@phil>
References: <3748421.ND1tAjvgKS@typ> <20140415185025.GH12304@sirena.org.uk>
 <5059282.MitP6iZ8n1@typ> <1917043.Q4CxE5T68K@phil>
Message-ID: <20140417231012.GI12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 03:27:36PM +0200, Heiko St?bner wrote:

> Interestingly, when looking through the regmap_config struct, it already 
> contains the "write_flag_mask", described as "Mask to be set in the top byte of 
> the register when doing  a write.", which sounds a lot like what we need, only 
> that it's two bytes for us instead of the current one.

> So I guess the easiest way would be to make write_flag_mask somehow usable for 
> us, because it looks like regmap will handle the rest on its own already.

> And then teach syscon to set this flag and about volatile registers in general, 
> because it doesn't seem to handle them yet.

How about a val_set_bits_mask or something?  That's not a good name, I'm
short on inspiration right now though.

Another option is to do something with pad_bits to tell regmap to insert
a block of set bits.  Not sure if that's sensible for MMIO though, it's
more sensible for I2C or SPI style register maps.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140418/dc6a2150/attachment.sig>
