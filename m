From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 7 Aug 2014 15:14:57 +0100
Subject: [PATCH v3 1/6] usb: host: usb-st-common: Add common code
 required by ohci-st and ehci-st
In-Reply-To: <201408062259.10697.arnd@arndb.de>
References: <1407344589-24863-1-git-send-email-peter.griffin@linaro.org>
 <1407344589-24863-2-git-send-email-peter.griffin@linaro.org>
 <201408062259.10697.arnd@arndb.de>
Message-ID: <20140807141457.GB12137@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for reviewing, see my comments below: -

> > +	if (priv->rst) {
> > +		ret = 
> > (priv->rst);
> > +		if (ret)
> > +			goto err_assert_power;
> > +	}
> 
> I wouldn't make these optional, just call the functions
> unconditionally and fail the probe function if they are
> not available.
> 
> I'm not sure if it's worth keeping these functions in a
> common file. You are adding complexity this way and I don't
> think you are even saving a significant number of code lines
> compared to just having two copies of them.

I've unabstracted these common functions back into ehci-st.c and 
ohci-st,c in V4.

regards,

Peter.
