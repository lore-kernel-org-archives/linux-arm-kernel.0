From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 May 2010 19:32:49 +0100
Subject: [PATCH v3 10/14] omap: mailbox: reorganize registering
In-Reply-To: <20100524.182407.67910029.Hiroshi.DOYU@nokia.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	<1274548465-20208-11-git-send-email-felipe.contreras@gmail.com>
	<20100524.182407.67910029.Hiroshi.DOYU@nokia.com>
Message-ID: <20100524183249.GF21117@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 24, 2010 at 06:24:07PM +0300, Hiroshi DOYU wrote:
> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: [PATCH v3 10/14] omap: mailbox: reorganize registering
> Date: Sat, 22 May 2010 19:14:21 +0200
> 
> > platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	if (unlikely(!res)) {
> > -		dev_err(&pdev->dev, "invalid mem resource\n");
> > -		return -ENODEV;
> > -	}
> > +	res = pdev->resource;
> 
> why not?
> 
> 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

I agree - always use the accessors provided rather than going beneath
the covers and fiddling directly with stuff inside objects.
