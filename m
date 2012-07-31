From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 31 Jul 2012 19:49:01 +0200
Subject: [PATCH 4/4] media: mx2_camera: Fix clock handling for i.MX27.
In-Reply-To: <Pine.LNX.4.64.1207311644590.27888@axis700.grange>
References: <1343301637-19676-1-git-send-email-javier.martin@vista-silicon.com>
 <1343301637-19676-5-git-send-email-javier.martin@vista-silicon.com>
 <Pine.LNX.4.64.1207311644590.27888@axis700.grange>
Message-ID: <20120731174901.GD30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

On Tue, Jul 31, 2012 at 05:14:25PM +0200, Guennadi Liakhovetski wrote:
> Hi Javier
> 
> > @@ -436,7 +436,8 @@ static void mx2_camera_deactivate(struct mx2_camera_dev *pcdev)
> >  {
> >  	unsigned long flags;
> >  
> > -	clk_disable(pcdev->clk_csi);
> > +	if (cpu_is_mx27())
> > +		clk_disable_unprepare(pcdev->clk_csi);
> 
> This tells me, there are already 2 things going on here:
> 
> 1. add clock-(un)prepare operations to enable / disable. Is this a problem 
> atm? is the driver non-functional without this change or is it just an API 
> correctness change? I thought you replied to this already, but 
> unfortunately I couldn't find that your reply again, sorry.

Since the common clock framework clk_prepare is mandatory.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
