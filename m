From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 15 Aug 2014 10:51:05 +0200
Subject: [PATCH v3] watchdog: Add DA906x PMIC watchdog driver.
In-Reply-To: <53ECD85A.8050903@roeck-us.net>
References: <1407926776-16700-1-git-send-email-mpa@pengutronix.de>
 <53EC487E.2000602@roeck-us.net>
 <20140814095733.GG17027@pengutronix.de>
 <53ECD85A.8050903@roeck-us.net>
Message-ID: <20140815085105.GH17027@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 08:40:10AM -0700, Guenter Roeck wrote:
> On 08/14/2014 02:57 AM, Markus Pargmann wrote:
> 
> >>>+
> >>>+static int da9063_wdt_probe(struct platform_device *pdev)
> >>>+{
> >>>+	int ret;
> >>>+	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
> >>>+	struct da9063_watchdog *wdt;
> >>>+
> >>>+	if (!da9063)
> >>>+		return -EPROBE_DEFER;
> >>
> >>Can this ever happen ? Isn't this driver instantiated from its parent,
> >>which would ensure that the parent's driver data is set ?
> >
> >No this can't happen. I replaced it with BUG_ON and also introduced a
> >BUG_ON check for dev.parent.
> >
> That is a bit too much. You should only use BUG_ON if the kernel can not
> continue to run, which should not be the case here. I would suggest
> to return -ENODEV.

Okay, thanks.

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140815/9dfe2659/attachment.sig>
