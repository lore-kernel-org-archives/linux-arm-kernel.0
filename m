From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 3 Dec 2014 09:26:19 +0000
Subject: [PATCH v2 2/8] mfd: MT6397: Add support for PMIC MT6397 MFD
In-Reply-To: <1417596018.24267.62.camel@mtksdaap41>
References: <1417146874-5232-1-git-send-email-flora.fu@mediatek.com>
 <1417146874-5232-3-git-send-email-flora.fu@mediatek.com>
 <20141201114717.GD15845@x1> <1417596018.24267.62.camel@mtksdaap41>
Message-ID: <20141203092619.GA327@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 03 Dec 2014, Flora Fu wrote:

> On Mon, 2014-12-01 at 11:47 +0000, Lee Jones wrote:
> > On Fri, 28 Nov 2014, Flora Fu wrote:
> 
> > 
> > > +	if (!mt6397)
> > > +		return -ENOMEM;
> > > +
> > > +	mt6397->dev = &pdev->dev;
> > 
> > Is this used else where?  If not, I think you can remove it.
> 
> No one is used it in this patch sets but it will be used for irq
> functions to get irq id or print logs for error case in the future.
> Can I keep it in the patch?

It's not uncommon for devices to do this and if you're sure it's going
to be used in the future you may as well keep it in.

> > > +	mt6397->regmap = wrp->regmap;
> > > +	platform_set_drvdata(pdev, mt6397);
> > 
> > Then you can platform_set_drvdata(pdev, regmap);
> > 
> > Although I don't see this being used either.  Is it used in the child
> > devices?
> > 
> Yes, it is used to provide regmap handle for its child device. In the
> patch set, regulator uses it.

Okay.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
