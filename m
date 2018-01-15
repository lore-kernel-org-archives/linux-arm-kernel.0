From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 15 Jan 2018 01:45:51 +0000
Subject: PM regression in next
In-Reply-To: <20180112225947.GL21458@sirena.org.uk>
References: <20180112002322.GB3875@atomide.com>	<20180111164537.79165ac8918e6d38e1837062@linux-foundation.org>	<20180112012019.GA4059@atomide.com>	<20180112190046.GD4821@atomide.com>	<20180112191251.GE21458@sirena.org.uk>	<20180112210706.GE4821@atomide.com>	<20180112211535.GH21458@sirena.org.uk>	<20180112215010.GG4821@atomide.com>	<20180112221126.GK21458@sirena.org.uk>	<20180112224959.GH4821@atomide.com>	<20180112225947.GL21458@sirena.org.uk>
Message-ID: <87wp0jzyig.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi all

> > > Most devices have one regmap per device which can be retrieved with
> > > dev_get_regmap(), it's the attempt to use that which I suspect is
> > > broken.  Like I said snd_soc_codec_init_regmap() ought to fix things if
> > > that's the issue.
> 
> > OK. Adding Peter to loop as it's his driver after all. Not sure
> > how well mixing regmap register access to the same module with
> > cached twl4030_read() would work :)
> 
> Yes, that local cache is not a super good idea any more and hopefully
> redundant.
> 
> > Maybe there should also be some big warning happening if
> > snd_soc_codec_init_regmap() is now needed and no regmap is
> > found?
> 
> Some devices just plain don't have registers at all (perhaps GPIOs or
> just stub drivers providing capability information).  However we should
> be screaming loudly about the fact that the I/O we tried to do fails,
> that clearly shouldn't be being ignored.

I'm sorry that my patch breaks your drivers.
It seems removing .read/.write callback was too much aggressive.
I hope your driver will be OK by using regmap.
In worst case, we can back .read/.write, but it will be component driver side.

Best regards
---
Kuninori Morimoto
