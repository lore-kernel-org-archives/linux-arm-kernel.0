From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed, 23 Dec 2015 13:52:45 +0100
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <20151223115632.GS16023@sirena.org.uk>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
 <20151223115632.GS16023@sirena.org.uk>
Message-ID: <1450875165.2648.7.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 23 d?cembre 2015 ? 11:56 +0000, Mark Brown a ?crit :
> On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:
> 
> > +	gpio = lp->pdata->enable_gpio;
> > +	if (!gpio_is_valid(gpio))
> > +		return 0;
> > +
> > +	/* Always set enable GPIO high. */
> > +	ret = devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP872X EN");
> > +	if (ret) {
> > +		dev_err(lp->dev, "gpio request err: %d\n", ret);
> > +		return ret;
> > +	}
> 
> This isn't really adding support for the enable GPIO as the changelog
> suggests, it's requesting but not managing the GPIO.  Since there is
> core support for manging enable GPIOs this seems especially silly,
> please tell the core about the GPIO and then it will work at runtime
> too.

You're right, I had clearly overlooked this, thanks for pointing it out.
Will send v2 using GPIO handling from core.

-- 
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151223/7258df16/attachment-0001.sig>
