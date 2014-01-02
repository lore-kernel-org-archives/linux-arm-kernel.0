From: broonie@kernel.org (Mark Brown)
Date: Thu, 2 Jan 2014 18:49:59 +0000
Subject: [PATCH 2/7] Input: pmic8xxx-pwrkey - Migrate to regmap APIs
In-Reply-To: <20131215113337.GB14818@core.coreip.homeip.net>
References: <1386718996-3733-1-git-send-email-sboyd@codeaurora.org>
 <1386718996-3733-3-git-send-email-sboyd@codeaurora.org>
 <20131215113337.GB14818@core.coreip.homeip.net>
Message-ID: <20140102184959.GI31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 15, 2013 at 03:33:37AM -0800, Dmitry Torokhov wrote:
> On Tue, Dec 10, 2013 at 03:43:11PM -0800, Stephen Boyd wrote:

> > +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> > +	if (!regmap)
> > +		return -ENODEV;

> And you are leaking memory here...

He's not, dev_get_regmap() just gets a pointer to an existing regmap -
no reference is taken and nothing is allocated.  It's a helper that's
mainly there so that generic code can be written without needing the
regmap to be passed around.  The caller is responsible for ensuring that
it will stick around for as long as it's used (generally by having it
lifetime managed with the device).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140102/f432fdfe/attachment.sig>
