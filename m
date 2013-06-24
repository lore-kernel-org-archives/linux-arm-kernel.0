From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 24 Jun 2013 15:49:53 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCB2MyA1LzVdIGRyaXZlcnM6IGJ1czogaW14LXdlaW06?=
 =?UTF-8?B?IEFkZCBzdXBwb3J0IGZvciBpLk1YMS8yMS8yNS8yNy8zMS8zNS81MC81MS81?=
 =?UTF-8?B?Mw==?=
In-Reply-To: <20130624113544.GA30747@S2101-09.ap.freescale.net>
References: <1371973698-16150-1-git-send-email-shc_work@mail.ru>
 <1371973698-16150-5-git-send-email-shc_work@mail.ru>
 <20130624113544.GA30747@S2101-09.ap.freescale.net>
Message-ID: <1372074593.303395301@f394.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Sun, Jun 23, 2013 at 11:48:18AM +0400, Alexander Shiyan wrote:
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> Can you write up something for the commit log?  Leaving it empty for
> such a patch with tens of LOC is not a nice thing.

OK.

...
> > @@ -81,6 +118,9 @@ static int __init weim_probe(struct platform_device *pdev)
> >  	void __iomem *base;
> >  	int ret;
> >  
> > +	if (!pdev->dev.of_node)
> > +		return -ENOTSUPP;
> > +
> Is it really necessary?  Since we only support DT probe, we can not
> reach here if the of_node is NULL.

In fact, nothing prevents to add to the board file line like
platform_device_register_simple ("imx-weim", 0, res, res_cnt);
In this case, the core will crush. I make it impossible to use.
Consider it unnecessary checks?
Thanks!

---
