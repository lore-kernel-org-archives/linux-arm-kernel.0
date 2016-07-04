From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Mon, 4 Jul 2016 10:28:52 +0800
Subject: [alsa-devel] [PATCH v5 6/9] ASoC: mediatek: add mt2701 platform
 driver implementation.
In-Reply-To: <1467293981.17087.18.camel@mtksdaap41>
References: <1466149440-23889-1-git-send-email-garlic.tseng@mediatek.com>
 <1466149440-23889-7-git-send-email-garlic.tseng@mediatek.com>
 <20160629191322.GT6247@sirena.org.uk>
 <1467293981.17087.18.camel@mtksdaap41>
Message-ID: <1467599332.11819.11.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-06-30 at 21:39 +0800, Garlic Tseng wrote:
> On Wed, 2016-06-29 at 20:13 +0100, Mark Brown wrote:
> > On Fri, Jun 17, 2016 at 03:43:57PM +0800, Garlic Tseng wrote:
> > 
> > > +static int mt2701_afe_i2s_set_clkdiv(struct snd_soc_dai *dai, int div_id,
> > > +				     int div)
> > > +{
> > 
> > Why are we adding a set_clkdiv() operation?  I would expect the driver
> > to be able to figure things out automatically.
> > 
> > > +	case DIV_ID_MCLK_TO_BCK:
> > > +		afe_priv->i2s_path[i2s_num].div_mclk_to_bck = div;
> > > +		break;
> > > +	case DIV_ID_BCK_TO_LRCK:
> > > +		afe_priv->i2s_path[i2s_num].div_bck_to_lrck = div;
> > > +		break;
> > 
> > Especially in the case where we're configuring LRCLK, that's trivial
> > when we know the sample rate which we have to know anyway.
> 
> Oh... actually I want to say 'div_mclk_over_bck' and 'div_bck_over_lrck'
> I'll fix the naming if we decide to reserve the set_clkdiv() operation.
> (omit some comment)

Hi Mark, I recognize that we can set mclk by set_sysclk, fix bck to 64fs
and let lrck be the same as sample rate so yes we don't need set_clkdiv.

Thanks for comment, I'll fix that in the next patch.

Garlic
