From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 27 Jun 2014 11:41:52 +0800
Subject: [PATCH v2 07/12] usb: chipidea: add a generic driver
In-Reply-To: <20140627032506.GA18039@shlinux1.ap.freescale.net>
References: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
 <1403606121-6368-8-git-send-email-antoine.tenart@free-electrons.com>
 <20140627032506.GA18039@shlinux1.ap.freescale.net>
Message-ID: <20140627034151.GC18039@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 11:25:07AM +0800, Peter Chen wrote:
> On Tue, Jun 24, 2014 at 12:35:16PM +0200, Antoine T?nart wrote:
> > Add a generic ChipIdea driver, with optional PHY and clock, to support
> > ChipIdea controllers that doesn't need specific functions.
> > 
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id ci_hdrc_generic_of_match[] = {
> > +	{ .compatible = "chipidea-usb" },
> > +	{ }
> > +};
> 
> Even as a generic driver, you can also use your own compatible string.
> 
> > +MODULE_DEVICE_TABLE(of, ci_hdrc_generic_of_match);
> > +
> > +static struct platform_driver ci_hdrc_generic_driver = {
> > +	.probe	= ci_hdrc_generic_probe,
> > +	.remove	= ci_hdrc_generic_remove,
> > +	.driver	= {
> > +		.name		= "chipidea-usb",
> > +		.owner		= THIS_MODULE,
> > +		.of_match_table	= ci_hdrc_generic_of_match,
> > +	},
> > +};
> > +module_platform_driver(ci_hdrc_generic_driver);
> > +
> > +MODULE_DESCRIPTION("Generic ChipIdea HDRC USB binding");
> > +MODULE_AUTHOR("Antoine T?nart <antoine.tenart@free-electrons.com>");
> > +MODULE_LICENSE("GPL");
> > -- 
> > 1.9.1
> > 
> 
> -- 
> 

Besides, I haven't seen dma_coerce_mask_and_coherent API calling,
where you set your dma mask?

-- 

Best Regards,
Peter Chen
