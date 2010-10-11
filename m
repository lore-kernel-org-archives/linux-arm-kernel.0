From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 11 Oct 2010 11:43:36 +0100
Subject: [PATCH 2/4] ASoC: add ep93xx AC97 audio driver
In-Reply-To: <20101011100742.GE27142@gw.healthdatacare.com>
References: <cover.1286707213.git.mika.westerberg@iki.fi>
	<b0202066df3bb9732fbecca627d0149165905a95.1286707213.git.mika.westerberg@iki.fi>
	<20101011094717.GA9231@rakim.wolfsonmicro.main>
	<20101011100742.GE27142@gw.healthdatacare.com>
Message-ID: <20101011104335.GC9231@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 01:07:42PM +0300, Mika Westerberg wrote:
> On Mon, Oct 11, 2010 at 10:47:18AM +0100, Mark Brown wrote:
> > On Sun, Oct 10, 2010 at 01:54:10PM +0300, Mika Westerberg wrote:

> > > +	mutex_lock(&info->lock);

> > > +	INIT_COMPLETION(info->done);

> > Do you really need to do this on every single register I/O?

> Sorry, didn't quite understand you. Do you mean that should I take
> the mutex and init the completion or wait for an interrupt?

You're doing INIT_COMPLETION every single time you use it - is that
really required?

> Yeah, sorry about that. I had the impression that using the latest
> mainline would be right thing to do :( I will base the next version
> against that tree pointed by Jassi.

Latest mainline means you're missing any changes that are ready for the
next merge window, once code has gone to Linus it's bugfix only outside
of the merge window so actual development happens in -next.
