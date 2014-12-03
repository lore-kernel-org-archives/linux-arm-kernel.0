From: flora.fu@mediatek.com (Flora Fu)
Date: Wed, 3 Dec 2014 16:40:18 +0800
Subject: [PATCH v2 2/8] mfd: MT6397: Add support for PMIC MT6397 MFD
In-Reply-To: <20141201114717.GD15845@x1>
References: <1417146874-5232-1-git-send-email-flora.fu@mediatek.com>
 <1417146874-5232-3-git-send-email-flora.fu@mediatek.com>
 <20141201114717.GD15845@x1>
Message-ID: <1417596018.24267.62.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-12-01 at 11:47 +0000, Lee Jones wrote:
> On Fri, 28 Nov 2014, Flora Fu wrote:

> 
> > +	if (!mt6397)
> > +		return -ENOMEM;
> > +
> > +	mt6397->dev = &pdev->dev;
> 
> Is this used else where?  If not, I think you can remove it.

No one is used it in this patch sets but it will be used for irq
functions to get irq id or print logs for error case in the future.
Can I keep it in the patch?

> 
> > +	mt6397->regmap = wrp->regmap;
> > +	platform_set_drvdata(pdev, mt6397);
> 
> Then you can platform_set_drvdata(pdev, regmap);
> 
> Although I don't see this being used either.  Is it used in the child
> devices?
> 
Yes, it is used to provide regmap handle for its child device. In the
patch set, regulator uses it.

Thanks,
Flora
