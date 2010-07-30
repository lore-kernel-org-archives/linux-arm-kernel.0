From: wookey@wookware.org (Wookey)
Date: Fri, 30 Jul 2010 14:07:55 +0100
Subject: [PATCH 11/13] [ARM] pxa/balloon3: PCF857x GPIO expander and LEDs
In-Reply-To: <201007301436.40920.marek.vasut@gmail.com>
References: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
	<20100730093939.GJ6845@dream.aleph1.co.uk>
	<201007301436.09905.marek.vasut@gmail.com>
	<201007301436.40920.marek.vasut@gmail.com>
Message-ID: <20100730130755.GL6845@dream.aleph1.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+++ Marek Vasut [2010-07-30 14:36 +0200]:
> Dne P? 30. ?ervence 2010 14:36:09 Marek Vasut napsal(a):
> > > > > support when the loon is used in this configuration. We have the
> > > > > balloon_has() macro which is used for dealing with the different
> > > > > builds of the board itself. 
> > > > >
> > > > > More obvious is using the CONFIG system to just enable this if
> > > > > CUED_IO_BOARD is configured.
> > > > 
> > > > You can just disable the PCF driver if you want to save space. In case
> > > > you won't have the CUED board connected, the driver will just fail to
> > > > probe so it's ok I believe.
> > > > 
> > > > The macro could be extended, but do we want such a weird stuff in
> > > > kernel?
> > > 
> > > That was how this list suggested we deal with the unprobe-able build
> > > variation, I beleive.
> > 
> > We have loadable kernel modules ever since ... long time ago. Maybe that's
> > more like the way to go.

But that makes it impossible to have a 'balloon' kernel that works on
different hardware builds. So far we have been able to have one kernel
build that works on all the different build variants by using that
macro to avoid doing things which will hang forever when hardware is
missing. Having to have a pile of different defconfigs for different
build options helps no-one (and we don't like defconfigs anymore
anyway :-)

More generic kernels is good, and ther has been much work on that sort
of thing recently. 

> > > > (especially if the driver can simply fail to probe).
> > > 
> > > No. Clearly anything that is probe-able should be probed. I thought
> > > thtat this wouldn't be as I2C devices are pretty dumb, but I guess we
> > > know its address here so we can try it and if no response then it's
> > > not there.
> > 
> > Yes, this one is probeable.
> 
> Re-adding Eric as he was dropped. Cheers

OK. Just to be clear I am not objecting to any of the stuff Marek is
posting here. It's great to have some of it upstream at last.

Once we have most of the basic support in we can consider the best
ways of dealing with the odd configuration issues of balloon variants
and add-on boards. (I'm not sure what you lot are going to think of
our Samosa bus - hopefuly it's not too ugly these days as we did make
it into a proper bus)

So, I am acking these patches. 

Wookey
-- 
Principal hats:  Linaro, Emdebian, Wookware, Balloonboard, ARM
http://wookware.org/
