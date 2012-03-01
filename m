From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 01 Mar 2012 13:26:18 +0900
Subject: [PATCH v3] S3C24XX DMA resume regression fix
In-Reply-To: <201202241417.24652.heiko@sntech.de>
References: <1330087227-10450-1-git-send-email-dron0gus@gmail.com>
 <201202241417.24652.heiko@sntech.de>
Message-ID: <076e01ccf763$72eefe30$58ccfa90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Am Freitag, 24. Februar 2012, 13:40:27 schrieb Gusakov Andrey:
> > s3c2410_dma_suspend suspends channels from 0 to dma_channels.
> > s3c2410_dma_resume resumes channels in reverse order. So
> > pointer should be decremented insted of being incremented.
> > ---
> >  arch/arm/plat-s3c24xx/dma.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
> > index 57abec9..16510d5 100644
> > --- a/arch/arm/plat-s3c24xx/dma.c
> > +++ b/arch/arm/plat-s3c24xx/dma.c
> > @@ -1249,7 +1249,7 @@ static void s3c2410_dma_resume(void)
> >  	struct s3c2410_dma_chan *cp = s3c2410_chans + dma_channels - 1;
> >  	int channel;
> >
> > -	for (channel = dma_channels - 1; channel >= 0; cp++, channel--)
> > +	for (channel = dma_channels - 1; channel >= 0; cp--, channel--)
> >  		s3c2410_dma_resume_chan(cp);
> >  }
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> it's interesting, that this is broken since april 2011, so I guess it's
> time
> to fix it :-)

Yes, absolutely. Will apply and send this with other fixes before 3.3
release.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
