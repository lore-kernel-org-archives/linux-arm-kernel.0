From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 10 Mar 2011 20:07:24 +0530
Subject: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle for GPT1
In-Reply-To: <alpine.DEB.2.00.1103100143230.15132@utopia.booyaka.com>
References: <alpine.DEB.2.00.1103091847150.15132@utopia.booyaka.com>
	<alpine.DEB.2.00.1103100143230.15132@utopia.booyaka.com>
Message-ID: <3b8b985f13158fbcd110cf45ed7035ad@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul, Benoit,

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Thursday, March 10, 2011 2:15 PM
> To: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Cc: Rajendra Nayak; Beno?t Cousson
> Subject: Re: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle
> for GPT1
>
> On Wed, 9 Mar 2011, Paul Walmsley wrote:
>
> > From: Rajendra Nayak <rnayak@ti.com>
> >
> > Some issues seen (which cause lockups in suspend) with GPT1
> > after the MPU<->L4_WKUP static dependency was cleared can be
> > Worked-around for now by forcing GPT1 in software
> > controlled idle.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
>
> Just a quick note, I missed Beno?t's update of the commit message:
>
>     http://www.spinics.net/linux/lists/linux-omap/msg48008.html
>
> and he's the maintainer of this so we should use his instead.  The
> revised
> message is below.
>

We continued further debug on the static dependency issues with
OMAP4 PM series.
So far from the findings what I have, this timer patch is actually not
needed and can be dropped. Infact the patch is not really effective
because current timer driver(not hwmod adapted yet) puts timer1
in smart idle again.

There is another static dep. just like MPUSS<-->EMIF seems to create
an issue. The lock-up is not very consistently reproducible so it's
very easy to get miss-leading results. Timer patch was one of those
observations. With or without timer patch I can reproduce the hang
with long duration test.

Will keep narrowing down the next offending static dependency but
in mean time I suggest you to drop this patch.

Regards,
Santosh
