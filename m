From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 21 Jun 2017 21:22:47 +0800
Subject: [PATCH 1/2] ASoC: add bindings for ZTE zx-aud96p22 audio codec
In-Reply-To: <20170620143352.rjitvgkzh554pviq@sirena.org.uk>
References: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
 <1497708574-22380-2-git-send-email-shawnguo@kernel.org>
 <20170619161606.g6nabi2w5mmmjbcw@sirena.org.uk>
 <20170620031131.GB4818@x250>
 <20170620143352.rjitvgkzh554pviq@sirena.org.uk>
Message-ID: <20170621132245.GD3372@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 03:33:52PM +0100, Mark Brown wrote:
> On Tue, Jun 20, 2017 at 11:11:32AM +0800, Shawn Guo wrote:
> > On Mon, Jun 19, 2017 at 05:16:06PM +0100, Mark Brown wrote:
> 
> > > If there's an external power amplifier this is a separate chip to this
> > > CODEC and should therefore be separately controlled and integrated as
> > > part of the machine integration.
> 
> > Yes, that should be the best.  But we do not have a particular machine
> > driver for our platform, and we are using simple-audio-card driver
> 
> You should be switching to the of-graph card now.

Thanks for the info.  Will do.

> > instead.  I'm not sure if it's generic enough to patch simple-audio-card
> > driver support this pa-gpios, so chose to fold this quick change in the
> > codec driver.
> 
> Having a separate amplifier is a completely normal thing, and no matter
> how unusual something is it's obviously not OK to hack one driver to
> support a completely different device.

Okay, I will drop it from codec driver, and try to support it in
audio-graph-card with separate patch later.

Shawn
