From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Apr 2014 18:55:04 +0100
Subject: Rockchip RK3188 I2C driver
In-Reply-To: <2745802.Mh5myQIMrf@phil>
References: <3748421.ND1tAjvgKS@typ> <3138967.5Gj2T0XUGf@phil>
 <2745802.Mh5myQIMrf@phil>
Message-ID: <20140415175504.GG12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 07:25:28PM +0200, Heiko St?bner wrote:

> Looking at the grf-handling of your i2c-driver [0] reminded me, that I'm 
> generally not sure how we should handle these registers. All of them use what 
> recently always got called a hiword-mask, with the upper 16 bit indicating 
> which lower 16 bit get changed.

> So while the

> 	regmap_write(grf, 4, BIT(11 + bus_idx) | BIT(27 + bus_idx));

> will most likely get the desired result at least once, I'm not sure how this 
> interacts with the caching regmap implements [and regmap in general], as the 
> bit(27 + bus_idx) is not a real value bit and will always read 0.

Can you be more specific what the wire format is here please?  The above
sounds like you're saying that the register value contains 32 bits, the
top 16 being essentially an extension of the register field and the last
16 bits being a value but that just sounds like 16+n bit registers and
16 bit data so presumably isn't what you mean.  Is there a datasheet
somewhere?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140415/7cfbc363/attachment.sig>
