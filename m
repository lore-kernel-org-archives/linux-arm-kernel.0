From: andi@etezian.org (Andi Shyti)
Date: Mon, 27 Jun 2016 23:08:27 +0900
Subject: [PATCH 1/5] spi: do not fail if the CS line is not connected
In-Reply-To: <20160627130657.GV28202@sirena.org.uk>
References: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
 <1466150245-2648-2-git-send-email-andi.shyti@samsung.com>
 <20160617104725.GC26099@sirena.org.uk>
 <20160617113622.GA10760@jack.zhora.eu>
 <20160617122803.GN26099@sirena.org.uk>
 <20160619060902.GB424@jack.zhora.eu>
 <CGME20160626124853epcas1p297070a25da8980f1d8d2f025c65cbdab@epcas1p2.samsung.com>
 <20160626124843.GP28202@sirena.org.uk>
 <20160627105716.GA7240@samsunx.samsung>
 <20160627130657.GV28202@sirena.org.uk>
Message-ID: <20160627140827.GF424@jack.zhora.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> > What I meant is that if we do not like num-cs = <0>, the
> > unlinked CS line can be handled only this way (case of the
> > s3c64xx driver):
> 
> > +- broken-cs: the CS line is disconnected, therefore the device should not wait
> > +  for the CS protocol to be established
> 
> So what you're saying here is that you just need a property for the
> inability to read back the chip select status?  That seems like a
> totally reasonable thing to have which fits in idiomatically with the
> rest of the subsystem.  I might call it no-cs-readback or something.
> 
> > Which is not something I like, because it means adding a new
> > flag in the dts.
> 
> > What I want to suggest, instead, is to slightly change the logic
> > behind the num-cs property: i.e. if "num-cs = <0>", doesn't
> > necessarily mean that we don't have a CS controller, but, while
> > we can have as many as we wish, non of them is connected.
> 
> I disagree, I think from a system integration point of view this is just
> a chip select which can't be changed and it's less likely that we will
> run into nasty surprises later on with things assuming that chip selects
> exist.  AFAICT you only need this property in your case because this
> controller has some features that rely on readback of the chip select
> status, that's not very common - normally it'd be write only.  I'd
> expect most controllers would just say they have one chip select and
> that'd be that.

thanks for your feedback, I will then do as you say, I will use
the no-cs-readback flag.

Thanks again,
Andi
