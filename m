From: j@jannau.net (Janne Grunau)
Date: Fri, 4 Sep 2015 00:28:04 +0200
Subject: [PATCH 2/2] arm64/apm: add dts for Gigabyte MP30-AR0 board
In-Reply-To: <20150902135753.GA15051@leverpostej>
References: <1440948270-1991-1-git-send-email-j@jannau.net>
 <1440948270-1991-3-git-send-email-j@jannau.net>
 <20150901105510.GB15900@leverpostej>
 <20150902075936.GR17056@jannau.net>
 <20150902135753.GA15051@leverpostej>
Message-ID: <20150903222804.GW17056@jannau.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-09-02 14:57:53 +0100, Mark Rutland wrote:
> > > > +};
> > > > diff --git a/arch/arm64/boot/dts/apm/mp30ar0.dts b/arch/arm64/boot/dts/apm/mp30ar0.dts
> > > > new file mode 100644
> > > > index 0000000..f7a9dae5
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/apm/mp30ar0.dts

[...]

> > > > +	};
> > > > +
> > > > +	poweroff_mbox: poweroff_mbox at 10548000 {
> > > > +		compatible = "syscon";
> > > > +		reg = <0x0 0x10548000 0x0 0x100>;
> > > > +	};
> > > > +
> > > > +	poweroff at 10548010 {
> > > > +		compatible = "syscon-poweroff";
> > > > +		regmap = <&poweroff_mbox>;
> > > > +		offset = <0x10>;
> > > > +		mask = <0x1>;
> > > > +	};
> > > > +
> > > > +	chosen {
> > > > +		linux,stdout-path = "/soc/serial at 1c020000";
> > > 
> > > Please use stdout-path rather than linux,stdout-path.
> > > 
> > > No rate configuration?
> > > 
> > > This would look nicer with an alias.
> > 
> > I can change that but the bootloader will add a 'linux,stdout-path' and 
> > the stdout-path will override it. OTOH the bootloader seems to always 
> > add this exact string so it will be fine to "override" it from the dts.
> > The alternative would to remove it.
> 
> I guess it doesn't fill in the rate, which is somewhat unfortunate.
> 
> Does it override an existing linux,stdout-path? If not, we could add the
> rate.

yes, it overrides an existing linux,stdout-path and it looks like an 
hardcoded string.

> I think we should have a comment about the bootlaoder filling in
> linux,stdout-path, but other than that I'm not really sure what the best
> option is.

I'll add the comment and a stdout-path with alias and rate. There is at 
least some hope that Gigabyte or APM will realease a newer/fixed 
bootloader. The installed bootloader doesn't clear x2/x3.

Thanks Janne
