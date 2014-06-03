From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Jun 2014 15:43:19 +0100
Subject: [PATCH 3/5] regulator: axp20x: Update the bindings to use a
 local parent regulator
In-Reply-To: <20140603131204.GJ27722@lukather>
References: <1401297069-7423-1-git-send-email-maxime.ripard@free-electrons.com>
 <1401297069-7423-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140528185051.GB22488@sirena.org.uk>
 <20140603131204.GJ27722@lukather>
Message-ID: <20140603144319.GD31751@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 03:12:04PM +0200, Maxime Ripard wrote:
> On Wed, May 28, 2014 at 07:50:51PM +0100, Mark Brown wrote:
> > On Wed, May 28, 2014 at 07:11:07PM +0200, Maxime Ripard wrote:

> > >  		axp_mic_reg: ldo5 {
> > > +			vin-supply = <&axp_ipsout_reg>;

> > This is saying that every single regulator on the device is powered by a
> > (presumably) single input called "vin".  This would certainly be an
> > unusual package design...  As ever the name of the supply should follow
> > the name of the pin on the device.

> Not exactly. Each regulator has its own input pin, named
> <regulator_name>in in the schematics, with the exception of LDO2 and
> LDO4 that share the same pin.

OK, so the supplies should be called <regulator_name>in then not vin.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140603/311e4ddb/attachment.sig>
