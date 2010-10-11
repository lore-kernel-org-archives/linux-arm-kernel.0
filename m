From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Mon, 11 Oct 2010 10:47:31 +0300
Subject: [PATCH 3/4] ARM: ep93xx: add AC97 platform support
In-Reply-To: <4CB2166D.5080706@bluewatersys.com>
References: <cover.1286707213.git.mika.westerberg@iki.fi>
	<d63475d15634d7ffa4c4167cbead782a5aa1cfc9.1286707213.git.mika.westerberg@iki.fi>
	<4CB2166D.5080706@bluewatersys.com>
Message-ID: <20101011074731.GD27142@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 08:39:25AM +1300, Ryan Mallon wrote:
> On 10/10/2010 11:54 PM, Mika Westerberg wrote:
> > +
> > +void __init ep93xx_register_ac97(void)
> > +{
> > +	/*
> > +	 * Make sure that the AC97 pins are not used by I2S.
> > +	 */
> > +	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2SONAC97);
> > +	platform_device_register(&ep93xx_ac97_device);
> > +}
> 
> The other ep93xx device support functions do this with acquire/release
> functions. However, it is quite unlikely that a board will ever need to
> switch from i2s to ac97 audio at runtime. Will see what Hartley thinks.

There is really no other option where to connect the AC97 codec.
In cases where both are needed, one needs to mux I2S to the SSP
pins. So not sure whether it makes sense to make the switch work
at runtime.

Thanks,
MW
