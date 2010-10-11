From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Mon, 11 Oct 2010 15:17:21 +0300
Subject: [PATCH 2/4] ASoC: add ep93xx AC97 audio driver
In-Reply-To: <20101011104335.GC9231@rakim.wolfsonmicro.main>
References: <cover.1286707213.git.mika.westerberg@iki.fi>
	<b0202066df3bb9732fbecca627d0149165905a95.1286707213.git.mika.westerberg@iki.fi>
	<20101011094717.GA9231@rakim.wolfsonmicro.main>
	<20101011100742.GE27142@gw.healthdatacare.com>
	<20101011104335.GC9231@rakim.wolfsonmicro.main>
Message-ID: <20101011121721.GG27142@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 11:43:36AM +0100, Mark Brown wrote:
> 
> You're doing INIT_COMPLETION every single time you use it - is that
> really required?

Ah, now I get it.

It seems that while I only use complete() there is no need for
calling INIT_COMPLETION() everytime. Will remove from the next
version.

> > Yeah, sorry about that. I had the impression that using the latest
> > mainline would be right thing to do :( I will base the next version
> > against that tree pointed by Jassi.
> 
> Latest mainline means you're missing any changes that are ready for the
> next merge window, once code has gone to Linus it's bugfix only outside
> of the merge window so actual development happens in -next.

Understood, thanks.

MW
