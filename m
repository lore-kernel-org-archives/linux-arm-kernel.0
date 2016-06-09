From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Jun 2016 23:06:21 +0200
Subject: [PATCH 2/4] ASoC: sunxi: Add Allwinner A10 Digital Audio driver
In-Reply-To: <CAEKpxBmLb27WYqB5SMhKqTw2cTznNEZVJdxEFKkwCY03JsdyVg@mail.gmail.com>
References: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
 <20160601175430.11625-3-maxime.ripard@free-electrons.com>
 <CAEKpxBmLb27WYqB5SMhKqTw2cTznNEZVJdxEFKkwCY03JsdyVg@mail.gmail.com>
Message-ID: <20160609210621.GJ5242@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Thu, Jun 02, 2016 at 10:03:21AM +0200, Code Kipper wrote:
> snip
> > +
> > +       /* Always favor the highest oversampling rate */
> > +       for (i = (ARRAY_SIZE(sun4i_i2s_oversample_rates) - 1); i >= 0; i--) {
> > +               unsigned int oversample_rate = sun4i_i2s_oversample_rates[i];
> > +
> > +               bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
> > +                                                 word_size);
> > +               mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
> > +                                                 clk_rate,
> > +                                                 rate);
> > +
> > +               if ((bclk_div >= 0) && (mclk_div >= 0))
> > +                       break;
> > +       }
> > +
> > +       if (bclk_div < 0 && mclk_div < 0)
>
> this wouldn't work if one of the divs returns a valid value and I saw
> this when working with this driver. Use if ((bclk_div < 0) ||
> (mclk_div < 0)). Rest of the code looks code and I will have a go at
> testing with it ASAP,

Ack, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/ecdb93f5/attachment.sig>
