From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 12 Sep 2012 18:21:02 +0200
Subject: [PATCH v5 1/5] usb: phy: samsung: Introducing usb phy driver for
 hsotg
In-Reply-To: <50506D2A.7040908@pengutronix.de>
References: <1347446757-20519-1-git-send-email-p.paneri@samsung.com>
 <1347446757-20519-2-git-send-email-p.paneri@samsung.com>
 <50506D2A.7040908@pengutronix.de>
Message-ID: <33690123.AyeJMS7yMW@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Praveen, Marc,

On Wednesday 12 of September 2012 13:08:26 Marc Kleine-Budde wrote:
> > +static const struct of_device_id samsung_usbphy_dt_match[];
> > +
> > +static inline int samsung_usbphy_get_driver_data(struct
> > platform_device *pdev) +{
> > +#ifdef CONFIG_OF
> 
> if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)

Is this check needed at all?

In case of CONFIG_OF disabled, of_node should always be NULL and there is a 
dummy macro provided for of_match_node, so it should compile and work just 
fine.

--
Best regards,
Tomasz Figa
