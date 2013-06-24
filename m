From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 24 Jun 2013 20:38:19 +0800
Subject: [PATCH v3 5/5] drivers: bus: imx-weim: Add support for
 i.MX1/21/25/27/31/35/50/51/53
In-Reply-To: <1372074593.303395301@f394.i.mail.ru>
References: <1371973698-16150-1-git-send-email-shc_work@mail.ru>
 <1371973698-16150-5-git-send-email-shc_work@mail.ru>
 <20130624113544.GA30747@S2101-09.ap.freescale.net>
 <1372074593.303395301@f394.i.mail.ru>
Message-ID: <20130624123817.GB30747@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 03:49:53PM +0400, Alexander Shiyan wrote:
> > > @@ -81,6 +118,9 @@ static int __init weim_probe(struct platform_device *pdev)
> > >  	void __iomem *base;
> > >  	int ret;
> > >  
> > > +	if (!pdev->dev.of_node)
> > > +		return -ENOTSUPP;
> > > +
> > Is it really necessary?  Since we only support DT probe, we can not
> > reach here if the of_node is NULL.
> 
> In fact, nothing prevents to add to the board file line like
> platform_device_register_simple ("imx-weim", 0, res, res_cnt);

Reasonability prevents that:

1) We no longer accept any changes like that.
2) The device driver does not work with platform probe anyway.  What's
   the point of doing that?

> In this case, the core will crush. I make it impossible to use.
> Consider it unnecessary checks?

Yes, unnecessary check for me.

Shawn
