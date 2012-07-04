From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 4 Jul 2012 09:11:59 +0200
Subject: Clock problems in i.MX27 Visstrim M10 (linux-3.5-rc5).
In-Reply-To: <CACKLOr0z13sMQhb14YpDp7UtwfhVoqRAMOJCA+geapq=Lh7VuQ@mail.gmail.com>
References: <CACKLOr0z13sMQhb14YpDp7UtwfhVoqRAMOJCA+geapq=Lh7VuQ@mail.gmail.com>
Message-ID: <20120704071159.GJ2698@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 01:09:52PM +0200, javier Martin wrote:
> Hi,
> I've found the following problems in linux-3.5-rc5
> (6887a4131da3adaab011613776d865f4bcfb5678) in our Visstrim M10 board:
> 
> At boot:
> 
> Moreover, the following 'clk_get()' fails in mx2_camera.c driver:
> 
> 	pcdev->clk_emma = clk_get(NULL, "emma");
> 	if (IS_ERR(pcdev->clk_emma)) {
> 		err = PTR_ERR(pcdev->clk_emma);
> 		goto exit_free_irq;
> 	}
> 
> 
> I know you guys have been doing some hard deep job with the clocks in
> the i.MX. I've tried a bisect but it's highly thedious since there are
> a lot of commits that do not compile:
> 

[...]

> Do you have any hints of what could have been broken? I'll keep on
> searching meanwhile.

Mainly these two problems exist:

- missing clk_prepare (or clk_prepare_enable)
- missing (or mismatching) clk_register_clkdev

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
