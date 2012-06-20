From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 Jun 2012 16:20:44 +0200
Subject: [PATCH v5] ARM: imx: Add basic imx6q cpu thermal management
In-Reply-To: <CAMXH7KE0Ei5cZLCOuO-hxBXW8WX48VhxNs2FxPV8biDNqzRY5A@mail.gmail.com>
References: <1340175964-4043-1-git-send-email-rob.lee@linaro.org>
 <1340175964-4043-2-git-send-email-rob.lee@linaro.org>
 <20120620101127.GS28394@pengutronix.de>
 <CAMXH7KE0Ei5cZLCOuO-hxBXW8WX48VhxNs2FxPV8biDNqzRY5A@mail.gmail.com>
Message-ID: <20120620142044.GU28394@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 09:12:51AM -0500, Rob Lee wrote:
> Sascha, thanks for the review.
> 
> >> +
> >> +static struct imx6q_thermal_zone ? ? *th_zone;
> >> +static void __iomem ? ? ? ? ? ? ? ? ?*ocotp_base;
> >
> > This is a driver and drivers should generally be multi instance safe.
> >
> 
> I don't understand what this comment is referring to.  Could you elaborate?

Drivers can only be multi instance safe when all variables are inside a
instance specific struct and you pass a pointer to this struct around.
What if the i.MX7 has two different ocotp_base and you want to use this
driver on both ocotp?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
