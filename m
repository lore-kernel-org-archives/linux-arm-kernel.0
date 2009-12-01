From: ben@trinity.fluff.org (Ben Dooks)
Date: Tue, 1 Dec 2009 18:08:51 +0000
Subject: [PATCH 1/7] S3C64XX: Staticise platform data for PCM devices
In-Reply-To: <1b68c6790911271740i3323528eqefbe71ef4c793518@mail.gmail.com>
References: <20091127164312.GA11913@rakim.wolfsonmicro.main>
	<1259340239-12067-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1b68c6790911271740i3323528eqefbe71ef4c793518@mail.gmail.com>
Message-ID: <20091201180851.GJ4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2009 at 10:40:47AM +0900, jassi brar wrote:
> On Sat, Nov 28, 2009 at 1:43 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > The symbols aren't declared and don't need to be exported, they go
> > along with the device structure.
> yes, that was a careless omission on my part. thanks.

would be nice to supply an Acked-by: line if you think this is a good idea.
 
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > ---
> > ?arch/arm/plat-s3c64xx/dev-audio.c | ? ?4 ++--
> > ?1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/plat-s3c64xx/dev-audio.c b/arch/arm/plat-s3c64xx/dev-audio.c
> > index 9e07344..a21a88f 100644
> > --- a/arch/arm/plat-s3c64xx/dev-audio.c
> > +++ b/arch/arm/plat-s3c64xx/dev-audio.c
> > @@ -118,7 +118,7 @@ static struct resource s3c64xx_pcm0_resource[] = {
> > ? ? ? ?},
> > ?};
> >
> > -struct s3c_audio_pdata s3c_pcm0_pdata = {
> > +static struct s3c_audio_pdata s3c_pcm0_pdata = {
> > ? ? ? ?.cfg_gpio = s3c64xx_pcm_cfg_gpio,
> > ?};
> >
> > @@ -151,7 +151,7 @@ static struct resource s3c64xx_pcm1_resource[] = {
> > ? ? ? ?},
> > ?};
> >
> > -struct s3c_audio_pdata s3c_pcm1_pdata = {
> > +static struct s3c_audio_pdata s3c_pcm1_pdata = {
> > ? ? ? ?.cfg_gpio = s3c64xx_pcm_cfg_gpio,
> > ?};
> >
> > --
> > 1.6.5.3
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
