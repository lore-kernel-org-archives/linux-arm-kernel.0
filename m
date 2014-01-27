From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Jan 2014 20:49:10 +0000
Subject: [PATCH RFC v3 4/8] ASoC: davinci-evm: HDMI audio support for
 TDA998x trough McASP I2S bus
In-Reply-To: <86fcca2ecf302a695e7fd8199a1d635a67bbfcc8.1390836773.git.jsarha@ti.com>
References: <cover.1390836773.git.jsarha@ti.com>
 <86fcca2ecf302a695e7fd8199a1d635a67bbfcc8.1390836773.git.jsarha@ti.com>
Message-ID: <20140127204910.GB11841@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 05:37:53PM +0200, Jyri Sarha wrote:
> Add machine driver support for BeagleBone-Black and other boards with
> tilcdc support and NXP TDA998X HDMI transmitter connected to McASP
> port in I2S mode. McASP produces the bit clock for the i2s bus from
> the masted clock by a simple divider and the available sample rates

I have to say I agree with Lars' comments about where the code to set
the constraints is here - I don't doubt that these limitations are valid
but it would be better to factor them into the relevant chip drivers so
that other systems with similar limitations can be handled correctly
too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140127/9e5ad4e2/attachment.sig>
