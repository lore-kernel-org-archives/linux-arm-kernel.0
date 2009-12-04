From: ospite@studenti.unina.it (Antonio Ospite)
Date: Fri, 4 Dec 2009 13:39:43 +0100
Subject: [PATCH] leds: Add LED class driver for regulator driven LEDs.
In-Reply-To: <20091202180658.GA12292@rakim.wolfsonmicro.main>
References: <1259775625-25973-1-git-send-email-ospite@studenti.unina.it>
	<20091202180658.GA12292@rakim.wolfsonmicro.main>
Message-ID: <20091204133943.ddf0e53d.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Dec 2009 18:06:58 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > +	vcc = regulator_get(&pdev->dev, pdata->supply);
> > +	if (IS_ERR(vcc)) {
> > +		dev_err(&pdev->dev, "Cannot get vcc for %s\n", pdata->name);
> > +		return PTR_ERR(vcc);;
> > +	}
> 
> You almost certainly want regulator_get_exclusive() here; this driver
> can't function properly if something else is using the regulator and
> holding the LED on or off without it.  You'll also want to check the
> status of the LED on startup and update your internal status to match
> that.

When you refer to "the status of the LED on startup" do you mean a
initial brightness value passed via leds-regulator platform data, or the
initial status or the regulator itself?

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091204/315580c2/attachment.sig>
