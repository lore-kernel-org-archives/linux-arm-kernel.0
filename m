From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 26 Jul 2013 16:21:16 +0200
Subject: [PATCH V2 2/8] ASoC: Samsung: I2S: Add quirks as driver data	in
 I2S
In-Reply-To: <20130726140618.GP24642@n2100.arm.linux.org.uk>
References: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
 <1374845812-7803-3-git-send-email-padma.v@samsung.com>
 <20130726140618.GP24642@n2100.arm.linux.org.uk>
Message-ID: <1479924.YVrWxe87Mh@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Friday 26 of July 2013 15:06:18 Russell King - ARM Linux wrote:
> On Fri, Jul 26, 2013 at 07:06:46PM +0530, Padmavathi Venna wrote:
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
> So what happens with your changes to everyone who is using a DT file with
> the "samsung,i2s-v5" compatible string?

AFAIK we decided that current bindings, if broken, can be redone correctly, 
without caring for compatibility with old DTBs and only then, after 
reviewing these new bindings by DT people, they can be stabilized.

Other issue, though, is that this patch breaks things until they get fixed 
by patch 3. Support for new bindings should be added first, then users fixed 
and only then old bindings can be removed.

Best regards,
Tomasz
