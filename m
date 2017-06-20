From: broonie@kernel.org (Mark Brown)
Date: Tue, 20 Jun 2017 13:40:59 +0100
Subject: [PATCH 2/2] ASoC: zx_aud96p22: add ZTE ZX AUD96P22 codec driver
In-Reply-To: <20170620031953.GC4818@x250>
References: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
 <1497708574-22380-3-git-send-email-shawnguo@kernel.org>
 <20170619161910.siea75hqxgtxhjmp@sirena.org.uk>
 <20170620031953.GC4818@x250>
Message-ID: <20170620124059.r55r363y3y3if6jg@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 11:19:55AM +0800, Shawn Guo wrote:
> On Mon, Jun 19, 2017 at 05:19:10PM +0100, Mark Brown wrote:
> > On Sat, Jun 17, 2017 at 10:09:34PM +0800, Shawn Guo wrote:

> > > +	/* Overall power-up */
> > > +	regmap_update_bits(regmap, AUD96P22_PD_0, PD_0_PDZ, PD_0_PDZ);

> > Why is this not done with DAPM?

> As this is a overall power bit, which is not for any specific component.
> I'm not sure which DAPM widget should be used for it, and how it should
> be arranged in the widget route.  Any suggestion or example will be
> appreciated.

Sounds like a fairly standard use for a supply widget.

> > > +	/* Reset ADC and DAC path */
> > > +	regmap_write(regmap, AUD96P22_RESET, 0x0);
> > > +	regmap_write(regmap, AUD96P22_RESET, 0x3);

> > What does this mean?

> It's a de-assert/assert of ADC and DAC reset.  I will add proper
> defines for the bits to make this clear.

Why are we resetting these - won't this loose settings?  And if it's
just something to be done as part of starting the DAC and ADC why isn't
it done via DAPM?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170620/6b593e76/attachment-0001.sig>
