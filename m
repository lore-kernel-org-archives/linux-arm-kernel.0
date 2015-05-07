From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 7 May 2015 20:37:18 +0200 (CEST)
Subject: [PATCH V2 5/6] regulator: add mxs on-chip regulator driver
In-Reply-To: <1693367404.879766.1430771695242.JavaMail.open-xchange@oxbaltgw08.schlund.de>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com>
 <20150504123648.GU15510@sirena.org.uk>
 <1693367404.879766.1430771695242.JavaMail.open-xchange@oxbaltgw08.schlund.de>
Message-ID: <1875749167.82542.1431023838932.JavaMail.open-xchange@oxbsltgw04.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> Stefan Wahren <stefan.wahren@i2se.com> hat am 4. Mai 2015 um 22:34
> geschrieben:
>
>
> Hi Mark,
>
> > Mark Brown <broonie@kernel.org> hat am 4. Mai 2015 um 14:36 geschrieben:
> >
> >
> > On Wed, Apr 29, 2015 at 10:32:26PM +0000, Stefan Wahren wrote:
> >
> > > +static struct regulator_ops mxs_dcdc_ops = {
> > > + .is_enabled = regulator_is_enabled_regmap,
> > > +};
> >
> > Why do we have an is_enabled() operation but no enable or disable
> > operation?
>
> i'm sorry, i forgot the following point in the changelog:
>
> - move dcdc handling from mxs_power to mxs-regulator
>
> I hope the change is okay. I implemented only is_enabled() to have at least 1
> operation.
> But it's not really necessary.

do we need enable / disable operation?

In the bootloader code enabling the DC-DC is critical. There is a known issue
which falsely triggers the brownout detection.

>
> > I'm also not 100% clear what code the DCDCs and LDOs are
> > sharing here...
>
> Actually only probing and the regulator info structure.

How can i improve that?

>
> Best regards
> Stefan
