From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 26 May 2015 11:37:34 -0700
Subject: [PATCH] pinctrl: zynq: change error code for pinctrl_register
 failure
In-Reply-To: <4437293.G26yCXqFQH@wuerfel>
References: <1432613909-13457-1-git-send-email-yamada.masahiro@socionext.com>
 <4437293.G26yCXqFQH@wuerfel>
Message-ID: <20150526183734.GA31081@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-05-26 at 10:12AM +0200, Arnd Bergmann wrote:
> On Tuesday 26 May 2015 13:18:29 Masahiro Yamada wrote:
> > diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
> > index 04748a4..0ff653c 100644
> > --- a/drivers/pinctrl/pinctrl-zynq.c
> > +++ b/drivers/pinctrl/pinctrl-zynq.c
> > @@ -1141,7 +1141,7 @@ static int zynq_pinctrl_probe(struct platform_device *pdev)
> >  
> >         pctrl->pctrl = pinctrl_register(&zynq_desc, &pdev->dev, pctrl);
> >         if (!pctrl->pctrl)
> > -               return -ENOMEM;
> > +               return -EINVAL;
> >  
> >         platform_set_drvdata(pdev, pctrl);
> >  
> > 
> 
> One choice seems as bad as the other to me ;-)
> 
> Could we add a pinctrl_register_reason() variant that returns a meaningful
> error code as ERR_PTR?

I agree with Arnd. As long as we don't get a precise error code we can
just keep the current one.

	S?ren
