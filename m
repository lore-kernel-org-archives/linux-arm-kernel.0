From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 16:49:47 +0100
Subject: [PATCH 03/17] ARM: pxa/raumfeld: add SMSC9220 ethernet support
In-Reply-To: <4B0D4CAC.9080403@compulab.co.il>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-4-git-send-email-daniel@caiaq.de>
	<4B0D4CAC.9080403@compulab.co.il>
Message-ID: <20091125154947.GP29442@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 05:26:36PM +0200, Mike Rapoport wrote:
> Daniel Mack wrote:
> > +static mfp_cfg_t raumfeld_eth_pin_config[] __initdata = {
> > +	GPIO1_nCS2,			/* CS */
> > +	GPIO40_GPIO | MFP_PULL_HIGH,	/* IRQ */
> > +};
> 
> Wouldn't it be better to keep mfp tables for common pins and each of board
> variants rather than configure mfp for particular interface? This applies for
> other patches that have
> +	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_<something>_pin_config));
> as well. :)

I had it that way, but the idea is to prevent double definitions. What
we have now is a config for all pins needed by the ethernet device, and
each machine which needs that just references it. It looks more straight
forward this way, but eventually that might be a matter of taste :)

Unless anyone has a strong opinion abouth that, I'd like to keep it as
it is now.

Daniel
