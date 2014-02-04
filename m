From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 23:22:11 +0000
Subject: [PATCH 4/6] regulator: add bcm59056 regulator driver
In-Reply-To: <20140204212914.GB16179@beef>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-5-git-send-email-mporter@linaro.org>
 <20140204172836.GH22609@sirena.org.uk>
 <20140204212914.GB16179@beef>
Message-ID: <20140204232211.GE22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 04:29:14PM -0500, Matt Porter wrote:
> On Tue, Feb 04, 2014 at 05:28:36PM +0000, Mark Brown wrote:

> > > +		/*
> > > +		 * Regulator API handles empty constraints but not NULL
> > > +		 * constraints
> > > +		 */
> > > +		if (!reg_data)
> > > +			continue;

> > It should do...  if not then make it so since that'd mean most drivers
> > are buggy.

> Ahh, I see there is a check for NULL in the core. Will drop.

It was missing in some older kernels (much older now IIRC) - it's
possible that comment was written before this got fixed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/41224047/attachment.sig>
