From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 16 Oct 2012 10:49:47 +0200
Subject: [PATCH 2/2] ASoC: atmel-ssc: use module_platform_driver macro
In-Reply-To: <507D15C2.7000606@atmel.com>
References: <1350359819-2461-1-git-send-email-voice.shen@atmel.com>
 <1350359819-2461-2-git-send-email-voice.shen@atmel.com>
 <507D15C2.7000606@atmel.com>
Message-ID: <20121016084947.GD12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:07 Tue 16 Oct     , Nicolas Ferre wrote:
> On 10/16/2012 05:56 AM, Bo Shen :
> > This patch removes some code duplication by using module_platform_driver
> > 
> > Signed-off-by: Bo Shen <voice.shen@atmel.com>
> 
> Very good simplification but...
> 
> > ---
> >  drivers/misc/atmel-ssc.c |   18 ++++--------------
> >  1 file changed, 4 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> > index 23dcb76..ac00f83 100644
> > --- a/drivers/misc/atmel-ssc.c
> > +++ b/drivers/misc/atmel-ssc.c
> > @@ -68,7 +68,7 @@ void ssc_free(struct ssc_device *ssc)
> >  }
> >  EXPORT_SYMBOL(ssc_free);
> >  
> > -static int __init ssc_probe(struct platform_device *pdev)
> > +static int ssc_probe(struct platform_device *pdev)
> 
> Here you remove the __init altogether, maybe converting to __devinit is
> the proper replacement for this? I do not know myself but if anybody knows?
yes __devinit is mandatory

Best Regards,
J.
