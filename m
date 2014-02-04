From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 16:59:06 +0000
Subject: [PATCH 3/6] mfd: add bcm59056 pmu driver
In-Reply-To: <20140204143119.GA4627@beef>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-4-git-send-email-mporter@linaro.org>
 <20140204132951.GE13529@lee--X1> <20140204143119.GA4627@beef>
Message-ID: <20140204165906.GC22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 09:31:19AM -0500, Matt Porter wrote:
> On Tue, Feb 04, 2014 at 01:29:51PM +0000, Lee Jones wrote:

> > > +static struct i2c_driver bcm59056_i2c_driver = {
> > > +	.driver = {
> > > +		   .name = "bcm59056",
> > > +		   .owner = THIS_MODULE,
> > > +		   .of_match_table = of_match_ptr(bcm59056_of_match),

> > No need to use of_match_ptr() here.

> Will remove.

What using of_match_ptr() should do is allow the compiler to figure out
that the table isn't used when DT is disabled and discard it without
ifdefs.  Not sure if that actually works yet but that's the idea.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/867f1536/attachment.sig>
