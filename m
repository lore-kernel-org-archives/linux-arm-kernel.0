From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 16 Sep 2009 11:26:58 +0100
Subject: [PATCH 05/10] S3C I2S: lrsync function made to work with IRQs
	disabled.
In-Reply-To: <1b68c6790909151803t74698905o2712db68ce03ea01@mail.gmail.com>
References: <1253008957-10569-1-git-send-email-jassi.brar@samsung.com>
	<20090916001439.GD24720@trinity.fluff.org>
	<1b68c6790909151803t74698905o2712db68ce03ea01@mail.gmail.com>
Message-ID: <20090916102657.GC3589@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2009 at 10:03:41AM +0900, jassi brar wrote:
> On Wed, Sep 16, 2009 at 9:14 AM, Ben Dooks <ben-linux@fluff.org> wrote:

> > I don't think cpu_relax() gives a defined 'timeout' length, thus this
> > loop is of a very indeterminate length of timeout.

> Ofcourse the total delay is non-deterministic. Besides, there is no
> hard limit on the amount of time we want to wait on lrsync. And this
> non-deterministic delay comes into picture only when the I2S is
> broken. It is second best option to simply hanging.
> Total wait period is _atleast_ what we want, as is mentioned in the changelog.

The length of time you should need to wait for a LRCLK transition is
given by the sample rate - even 1ms is a very generous timeout for 8kHz,
which is the lowest sample rate you'd really expect to see.  The actual
value isn't terribly important since we should never hit it when things
aren't broken.
