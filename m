From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 29 Aug 2012 06:29:19 +0000
Subject: [alsa-devel] [PATCH V2 1/6] ASoC: davinci: davinci-pcm does not
 need to be a plaform_driver
In-Reply-To: <20120829062534.GB11919@newmaster.mivlgu.local>
References: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
 <1346074004-22172-2-git-send-email-gururaja.hebbar@ti.com>
 <20120829062534.GB11919@newmaster.mivlgu.local>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA6D3D0@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 11:55:34, Sergey Vlasov wrote:
> On Mon, Aug 27, 2012 at 06:56:39PM +0530, Hebbar, Gururaja wrote:
> > Same as the commit 518de86 (ASoC: tegra: register 'platform' from DAIs,
> > get rid of pdev). It makes davinci-pcm not a platform_driver but helper
> > to register "platform", so that the platform_device for davinci-pcm can
> > be saved completely.
> > 
> > Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> > ---
> > Changes from V1:
> > 	- New Commit. Instanciate seudo-device (davinci-pcm) directly from DAI
> > 	  driver rather than having a separate virtual-device registered
> > 
> > :100644 100644 c80c20a... 4b37e2a... M	sound/soc/davinci/davinci-evm.c
> > :100644 100644 0a74b95... 407df72... M	sound/soc/davinci/davinci-i2s.c
> > :100644 100644 6a2c54c... 34ee2f1... M	sound/soc/davinci/davinci-mcasp.c

...snip...
...snip...

> >  	.name = "Voice Codec - CQ93VC",
> >  	.stream_name = "CQ93",
> >  	.cpu_dai_name = "davinci-vcif",
> >  	.codec_dai_name = "cq93vc-hifi",
> >  	.codec_name = "cq93vc-codec",
> > +	.platform_name = "avinci-vcif",
> 
> Typo?
> 

Oops. Sorry. Will send back a corrected patch ASAP

Regards, 
Gururaja
