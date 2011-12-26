From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Dec 2011 17:23:50 +0000
Subject: [PATCH 4/4] ASoC: OMAP: ams-delta: drop .set_bias_level callback
In-Reply-To: <201112261330.22783.jkrzyszt@tis.icnet.pl>
References: <201112261330.22783.jkrzyszt@tis.icnet.pl>
Message-ID: <20111226172349.GK8722@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 26, 2011 at 01:30:22PM +0100, Janusz Krzysztofik wrote:

> > Why's this code not been dropped and what is it for?

> It is, and will be, used by another regulator consumer, the modem. The 
> device is controlled by the generic serial8250 driver, extended with a 
> custom .pm hook which enables/disables the regulator. The above code, 
> temporarily shared with the ASoC device before updated, is now just 
> moved down the board file where the modem related bits are located (see 
> patch 3/4).

> Any hints like that for the codec driver?

The main thing that looks bad here is that you're keeping track of the
state of the regulator by hand.  It may be that the upper layers aren't
reference counting in which case you might need this but it certainly
looks very suspicious as-is.
