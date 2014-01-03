From: broonie@kernel.org (Mark Brown)
Date: Fri, 3 Jan 2014 00:50:19 +0000
Subject: [PATCH 2/7] Input: pmic8xxx-pwrkey - Migrate to regmap APIs
In-Reply-To: <20140102191757.GA2025@core.coreip.homeip.net>
References: <1386718996-3733-1-git-send-email-sboyd@codeaurora.org>
 <1386718996-3733-3-git-send-email-sboyd@codeaurora.org>
 <20131215113337.GB14818@core.coreip.homeip.net>
 <20140102184959.GI31886@sirena.org.uk>
 <20140102191757.GA2025@core.coreip.homeip.net>
Message-ID: <20140103005019.GJ31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 11:17:57AM -0800, Dmitry Torokhov wrote:
> On Thu, Jan 02, 2014 at 06:49:59PM +0000, Mark Brown wrote:
> > On Sun, Dec 15, 2013 at 03:33:37AM -0800, Dmitry Torokhov wrote:

> > > > +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> > > > +	if (!regmap)
> > > > +		return -ENODEV;

> > > And you are leaking memory here...

> > He's not, dev_get_regmap() just gets a pointer to an existing regmap -
> > no reference is taken and nothing is allocated.  It's a helper that's

> I was not talking about data returned by dev_get_regmap() but all other
> memory that was allocated before as this was pre devm conversion of the
> driver.

Ah, OK - I thought you meant that as that was the code immediately prior
to your reply.  Sorry for the confusion.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/7a912409/attachment.sig>
