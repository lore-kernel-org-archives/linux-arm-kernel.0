From: david-b@pacbell.net (David Brownell)
Date: Fri, 25 Jun 2010 00:19:41 -0700 (PDT)
Subject: [RFC PATCH] Rework gpio cansleep (was Re: gpiolib and sleeping
	gpios)
In-Reply-To: <4C22A275.3030102@bluewatersys.com>
Message-ID: <683567.34621.qm@web180314.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Wed, 6/23/10, Ryan Mallon <ryan@bluewatersys.com> wrote:

> >> In the current code, if a driver ever calls
> gpio_(set/get)_value on a
> >> gpio then you cannot pass a sleeping gpio to that
> driver. The request
> >> will succeed,

No it won't.  Recall that those bit accessor
functions don't return success or failure!!

I'll be submitting a patch soonish, which is
a variant of Jani's patch to make the runtime
warnings trigger more consistently in the
face of such programming errors.
