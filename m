From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 25 Mar 2013 19:47:21 +0000
Subject: [PATCH v10 01/12] mfd: DT bindings for the palmas family MFD
In-Reply-To: <5150906F.9040202@wwwdotorg.org>
References: <1363964122-19201-1-git-send-email-ian@slimlogic.co.uk>
 <1363964122-19201-2-git-send-email-ian@slimlogic.co.uk>
 <5150906F.9040202@wwwdotorg.org>
Message-ID: <20130325194711.GT18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 11:59:11AM -0600, Stephen Warren wrote:
> On 03/22/2013 08:55 AM, Ian Lartey wrote:
> > From: Graeme Gregory <gg@slimlogic.co.uk>

> > +Optional nodes:
> > +- regulators : should contain the constrains and init information for the
> > +	       regulators. It should contain a subnode per regulator from the
> > +	       list.
> > +	       For ti,palmas-pmic - smps12, smps123, smps3 depending on OTP,
> > +	       smps45, smps457, smps7 depending on varient, smps6, smps[8-10],
> > +	       ldo[1-9], ldoln, ldousb
> > +	       For ti,palmas-charger-pmic - smps12, smps123, smps3 depending on OTP,
> > +	       smps[6-9], boost, ldo[1-14], ldoln, ldousb

> The list of legal compatible values for this node above doesn't include
> both ti,palmas-pmic and ti,palmas-charger-pmic. Should it? This node
> should describe this PMIC block in a completely standalone fashion,
> without the need to go look at the top-level node to see if it's a
> "charger" variant or not.

The latter was removed from the code in this series, only palmas-pmic is
present now.

Just as a general thing there seems to be an awful lot of stuff here
about the boilerplate for the generic properties like the interrupt
and GPIO controller stuff - we probably need to spin round and look at
factoring this out to make life easier.  There seems to be a lot of
boiler plate in the bindings that is factored out well by the frameworks
in the code so people don't even need to think about it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130325/8d8b256f/attachment.sig>
