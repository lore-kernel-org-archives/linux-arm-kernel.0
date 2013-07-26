From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 26 Jul 2013 17:02:46 +0200
Subject: [PATCH V2 2/8] ASoC: Samsung: I2S: Add quirks as driver data in
 I2S
In-Reply-To: <20130726145319.GI9858@sirena.org.uk>
References: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
 <1374845812-7803-3-git-send-email-padma.v@samsung.com>
 <20130726145319.GI9858@sirena.org.uk>
Message-ID: <1417636.4d7IlsSAyI@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 of July 2013 15:53:19 Mark Brown wrote:
> On Fri, Jul 26, 2013 at 07:06:46PM +0530, Padmavathi Venna wrote:
> > Samsung has different versions of I2S introduced in different
> > platforms. Each version has some new support added for multichannel,
> > secondary fifo, s/w reset control and internal mux for rclk src clk.
> > Each newly added change has a quirk. So this patch adds all the
> > required quirks as driver data and based on compatible string from
> > dtsi fetches the quirks.
> 
> As Russell indicated you should really keep the old name around, though
> marking them as deprecated is OK.  However I'm not sure anyone will have
> deployed this so I'm not sure how much it matters - every downstream
> kernel I've seen was still using board files anyway.
> 
> The actual meat of the patch changing to a quirk scheme does look good,
> though.
> 
> > -- compatible : "samsung,i2s-v5"
> > +- compatible : should be one of the following.
> > +   - samsung,s3c6410-i2s: for 8/16/24bit stereo I2S. Previous versions
> > +     has only 8/16bit support.
> > +   - samsung,s3c6410-i2sv4: for 8/16/24bit multichannel(5.1 channel)
> > I2S. +     Introduced in s3c6410. This also applicable for s5p64x0
> > platforms. +   - samsung,s5pc100-i2s: for 8/16/24bit multichannel(5.1
> > channel) I2S +     with secondary fifo and s/w reset control.
> > +   - samsung,s5pv210-i2s: for 8/16/24bit multichannel(5.1) I2S with
> > +     secondary fifo, s/w reset control and internal mux for root clk
> > src. +
> 
> I think the -vN naming scheme was fine - I see where this came from but
> the main point was about having things identified by a string not
> switching the naming scheme.  As you can see from the s3c6410 stuff the
> SoC isn't that helpful as a naming scheme as multiple IP versions appear
> on the same SoC.

IMHO this SoC-based identification looks much better, especially considering 
the fact that IP version isn't something easily determinable, as even the 
documentation can sometimes be not really clear about that.

However the s3c6410-i2sv4 string looks a bit unfortunate. AFAIK there were 
two types of I2S IPs on S3C6410 - normal I2S and I2S multichannel. What 
about having a compatible like s3c6410-i2s-multi?

Best regards,
Tomasz
