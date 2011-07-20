From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 20 Jul 2011 07:40:38 +0300
Subject: [PATCH v2] mtd: dataflash: add device tree probe support
In-Reply-To: <20110715044919.GB1840@S2100-06.ap.freescale.net>
References: <1310283313-32087-1-git-send-email-shawn.guo@linaro.org>
	<1310658757-17018-1-git-send-email-shawn.guo@linaro.org>
	<20110715025407.GF2927@ponder.secretlab.ca>
	<20110715044919.GB1840@S2100-06.ap.freescale.net>
Message-ID: <1311136844.20738.131.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-07-15 at 12:49 +0800, Shawn Guo wrote:
> > > +static const struct of_device_id dataflash_dt_ids[] = {
> > > +	{ .compatible = "atmel,at45xxx", },
> > > +	{ .compatible = "atmel,dataflash", },
> > > +	{ /* sentinel */ }
> > > +};
> > > +
> > 
> > This should be protected with a #ifdef CONFIG_OF/#else/#endif, and
> > there should be a MODULE_DEVICE_TABLE().
> > 
> I personally hate #ifdef stuff.  But okay, I can do it since there
> are people being concerned by this little waste of space.

I guess the question is - will it compile and work if CONFIG_OF is
unset?


-- 
Best Regards,
Artem Bityutskiy
