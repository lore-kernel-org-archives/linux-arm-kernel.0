From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 27 Oct 2010 10:56:21 -0700
Subject: [PATCH v2 1/2] regulator: add support for regulators on the
	ab8500 MFD
In-Reply-To: <AANLkTi=DRHVbz3ov_gL6qyYH673WDk+1Vyw2AvjhSRxv@mail.gmail.com>
References: <1279030173-3086-1-git-send-email-sundar.iyer@stericsson.com>
	<AANLkTinc50bzQawaoA_XfkLhJXjVjPWzxgbCJ40UnYwi@mail.gmail.com>
	<20101027173340.GA25134@opensource.wolfsonmicro.com>
	<AANLkTi=DRHVbz3ov_gL6qyYH673WDk+1Vyw2AvjhSRxv@mail.gmail.com>
Message-ID: <20101027175620.GB25134@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 27, 2010 at 03:42:53PM -0200, Thiago Farina wrote:
> On Wed, Oct 27, 2010 at 3:33 PM, Mark Brown

> > There is no reason to do this, logical values are treated as 0 and 1 in
> > C. ?Using false and true is clear and won't cause any difference in
> > code.

> In C99 I suppose that is true and legal?

Yes.  C has always used 1 and 0 as the numerical mappings for logical
values, the addition of the keywords did not change them.

> >> Maybe like this?
> >> return (ret & info->mask) ? 1: 0;

> > No, that's needlessly obfuscated.

> Obfuscated? What you mean? It is a driver, and people reading and
> writing a driver would know what it means, no?

Adding the ternery operator just makes the code more noisy for no
benefit.

> Would be much simpler if it was just (like done in ab3100.c):

> return (ret & info->mask);

Yes, though there's no problem with the current code either.
