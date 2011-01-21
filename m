From: sudhakar.raj@ti.com (Rajashekhara, Sudhakar)
Date: Fri, 21 Jan 2011 21:06:16 +0530
Subject: [PATCH] davinci: da8xx/omap-l1x: add platform device for
	davinci-pcm-audio
In-Reply-To: <4D39A4F4.9010809@mvista.com>
References: <1295622739-7885-1-git-send-email-sudhakar.raj@ti.com>
	<4D39A4F4.9010809@mvista.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930248509EA6@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Jan 21, 2011 at 20:53:32, Sergei Shtylyov wrote:
> Hello.
> 
> Rajashekhara, Sudhakar wrote:
> 
> > After the multi-component commit f0fba2ad
> 
>    Please also specify the commit summary in parens, as asked by Linus.
> 

Sure, will do it.

> > for ASoC, we need to
> > register the platform device for davinci-pcm-audio.
> 
> > This patch and patch at [1] are required for audio to work on
> > DA850/OMAP-L138.
> 
> > [1] https://patchwork.kernel.org/patch/495211/
> 
> > Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
> > Tested-by: Dan Sharon <dansharon@nanometrics.ca>
> > ---
> >  arch/arm/mach-davinci/devices-da8xx.c |   12 ++++++++++++
> >  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> > diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> > index 9eec630..062190b 100644
> > --- a/arch/arm/mach-davinci/devices-da8xx.c
> > +++ b/arch/arm/mach-davinci/devices-da8xx.c
> > @@ -480,8 +480,20 @@ static struct platform_device da850_mcasp_device = {
> >  	.resource	= da850_mcasp_resources,
> >  };
> >  
> > +struct platform_device davinci_pcm_device = {
> > +	.name	= "davinci-pcm-audio",
> > +	.id	= -1,
> > +};
> > +
> > +static void davinci_init_pcm(void)
> > +{
> > +	platform_device_register(&davinci_pcm_device);
> > +}
> > +
> >  void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata)
> >  {
> > +	davinci_init_pcm();
> 
>     Why not call platform_device_register() directly?
> 

This is a good suggestion. Anyhow I am calling only platform_device_register()
functions inside da8xx_register_mcasp(), so I can add this one as well.

Regards,
Sudhakar
