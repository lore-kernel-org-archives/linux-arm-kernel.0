From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jan 2012 14:50:02 +0000
Subject: linux-next: manual merge of the v4l-dvb tree with the arm-soc tree
In-Reply-To: <4F0D65F6.8080209@infradead.org>
References: <20120111133146.990e2b7115c9fa80e8fc3234@canb.auug.org.au>
 <Pine.LNX.4.64.1201110933480.1191@axis700.grange>
 <4F0D65F6.8080209@infradead.org>
Message-ID: <201201111450.02798.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 January 2012, Mauro Carvalho Chehab wrote:
> What I and Guennadi agreed (http://linuxtv.org/irc/v4l/index.php?date=2012-01-05)
> were to do just the reverse:
> 
> He would be sending you one single patch with my ack, that would allow the 
> arm tree to be merged [1], I would wait for a few days for the arm tree to
> be pulled, and then I would rebase my -next tree to remove that patch
> from it.
> 
> [1] http://git.linuxtv.org/gliakhovetski/v4l-dvb.git/commitdiff/88c6599d97b489ac543fa352159a81f60bddded7

It's just not what happened. I got this series from Nicolas:

7a1834b ARM: at91: Update struct atmel_nand_data to support PMECC
9356fba ARM: at91/dma: DMA controller registering with DT support
31527e7 ARM: at91/dma: remove platform data from DMA controller
226e3aa ARM: at91: add Atmel ISI and ov2640 support on sam9m10g45 board
e889a64 ARM: at91: add clock selection parameter for at91_add_device_isi()
7a13e73 media i.MX27 camera: Fix field_count handling.
166b37f media i.MX27 camera: add support for YUV420 format.
88c6599 V4L: atmel-isi: add code to enable/disable ISI_MCK clock
... (the rest of v4l at the time)

and I merged it into the next/drivers2 branch, explaining that I would
merge these as soon as the dependencies in v4l are merged. :(

> My -next tree were never meant to be stable. It is just a patch repository
> where I merge from the real development repository, in order to test them
> against the hole changes. From time to time, when bad things happen
> (patch conflicts, compilation breakages, requests to remove bad patches),
> I just rebase it.

Ok, thanks for the confirmation.

> I prefer if you could just pick this patch from Guennadi's tree:
>  http://git.linuxtv.org/gliakhovetski/v4l-dvb.git/commitdiff/88c6599d97b489ac543fa352159a81f60bddded7
>
> and add my ack on it, removing the v4l-dvb merge from yours.
>
> Linus seems to prefer to have the arch trees merged before the drivers
> tree, with makes sense.

I think it's better for you to just send everything you have right away,
including the atmel-isi patch.

I'll drop the remaining atmel patches from my next/drivers2 branch and let
Nicolas send me a new rebased pull request for 3.4. The patches in question
look simple enough, but if the developers can't get a simple dependency right
after discussing it for weeks, I'd rather not take it this time.

	Arnd
