From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 9 Dec 2013 09:44:25 +0100
Subject: [PATCH v2] serial: rewrite pxa2xx-uart to use 8250_core
In-Reply-To: <20131209083815.GA5231@xps8300>
References: <1386286149-2855-1-git-send-email-ynvich@gmail.com>
 <1386321003-8960-1-git-send-email-ynvich@gmail.com>
 <20131209083815.GA5231@xps8300>
Message-ID: <20131209084425.GO24559@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 10:38:15AM +0200, Heikki Krogerus wrote:
> Hi,
> 
> > +	return 0;
> > +
> > + err_clk:
> > +	clk_unprepare(data->clk);
> > + err_free_clk:
> > +	devm_clk_put(&pdev->dev, data->clk);
> > + err_free:
> > +	devm_kfree(&pdev->dev, data);
> 
> And there labels could be dropped.

This should really be fixed. Explicitly releasing devm_* allocated
resources invalidates the whole idea of the devm functions. People
looking for templates shouldn't find examples for this in the kernel.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
