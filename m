From: broonie@kernel.org (Mark Brown)
Date: Sat, 22 Mar 2014 17:33:13 +0000
Subject: [linux-sunxi] Re: [PATCH v2 1/8] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
In-Reply-To: <20140322165132.GC20668@localhost.fastwebnet.it>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-2-git-send-email-carlo@caione.org>
 <20140318155919.GS25478@lee--X1>
 <20140322165132.GC20668@localhost.fastwebnet.it>
Message-ID: <20140322173313.GU552@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 22, 2014 at 05:51:32PM +0100, Carlo Caione wrote:
> On Tue, Mar 18, 2014 at 03:59:19PM +0000, Lee Jones wrote:

> > > +	of_id = of_match_device(axp20x_of_match, &i2c->dev);
> > > +	if (!of_id) {
> > > +		dev_err(&i2c->dev, "Unable to setup AXP20X data\n");
> > > +		return -ENODEV;
> > > +	}
> > > +	axp20x->variant = (int) of_id->data;

> > No need to cast from void *.

> My compiler says otherwise :)

Are you sure your compiler isn't correctly telling you not to cast away
const?  If the compiler is complaining about a cast on void then it's
spotted a definite bug.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140322/634fefa6/attachment.sig>
