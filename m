From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 7 May 2015 21:25:19 +0200 (CEST)
Subject: [PATCH V2 5/6] regulator: add mxs on-chip regulator driver
In-Reply-To: <20150507185216.GP22845@sirena.org.uk>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com>
 <20150504123648.GU15510@sirena.org.uk>
 <1693367404.879766.1430771695242.JavaMail.open-xchange@oxbaltgw08.schlund.de>
 <1875749167.82542.1431023838932.JavaMail.open-xchange@oxbsltgw04.schlund.de>
 <20150507185216.GP22845@sirena.org.uk>
Message-ID: <535744342.64563.1431026719818.JavaMail.open-xchange@oxbsltgw09.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Mark Brown <broonie@kernel.org> hat am 7. Mai 2015 um 20:52 geschrieben:
>
>
> On Thu, May 07, 2015 at 08:37:18PM +0200, Stefan Wahren wrote:
> > > Stefan Wahren <stefan.wahren@i2se.com> hat am 4. Mai 2015 um 22:34
>
> > > i'm sorry, i forgot the following point in the changelog:
>
> > > - move dcdc handling from mxs_power to mxs-regulator
>
> > > I hope the change is okay. I implemented only is_enabled() to have at
> > > least 1
> > > operation.
> > > But it's not really necessary.
>
> > do we need enable / disable operation?
>
> > In the bootloader code enabling the DC-DC is critical. There is a known
> > issue
> > which falsely triggers the brownout detection.
>
> Why would the driver not provide these operations?

I didn't implement this operation because the suggested workaround for the
hardware issue isn't very nice 
(disable brownout detection during enabling DC-DC). I was afraid of the
implementation.

>
> > > > I'm also not 100% clear what code the DCDCs and LDOs are
> > > > sharing here...
>
> > > Actually only probing and the regulator info structure.
>
> > How can i improve that?
>
> If the devices aren't sharing code then they should be separate drivers.

Okay. 

mxs-regulator-ldo.c
mxs-regulator-dcdc.c

What do you think of?
