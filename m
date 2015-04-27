From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 27 Apr 2015 22:44:56 +0200 (CEST)
Subject: Question about DC-DC frequency handling
In-Reply-To: <20150426190729.16410.58019@quantum>
References: <604104768.496325.1430058690855.JavaMail.open-xchange@oxbaltgw00.schlund.de>
 <20150426190729.16410.58019@quantum>
Message-ID: <68391817.574800.1430167496498.JavaMail.open-xchange@oxbaltgw01.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Michael Turquette <mturquette@linaro.org> hat am 26. April 2015 um 21:07
> geschrieben:
>
>
> Quoting Stefan Wahren (2015-04-26 07:31:30)
> > Hi,
> >
> > i'm current working on a regulator driver which should be able to change
> > DC-DC
> > clock frequency.
> >
> > Now here is my question. What is the prefered way to implement the clock
> > handling?
>
> Fun question. I have a question for you: who are the consumers of this
> DC-DC? Do the downstream, consuming devices care about "clock rate" of
> your regulator?
>
> I'll hazard a guess that they do not care. DC-DC switching frequency is
> an important aspect of power supply design, but switching frequency of a
> power supply is not controlled by the clock framework in any example
> that I am aware of.

yes the consumers don't care. My intension for changing the switching frequency
is
to avoid interferences on HF band.

>
> >
> > Option A):
> >
> > The regulator driver handles all internally (select clock source, set
> > frequency).
>
> Mark should weigh in on this, but I think option A is correct. Maybe
> something like regulator_set_mode could program your switching
> frequency?

A runtime configuration isn't necessary. In a earlier discussion we decided to
use
a devicetree property.

Thanks

Stefan
