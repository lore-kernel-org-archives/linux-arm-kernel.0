From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Aug 2010 17:48:51 +0200
Subject: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
In-Reply-To: <20100819152301.GB25193@ovro.caltech.edu>
References: <cover.1281956490.git.richard.cochran@omicron.at>
	<201008191429.50008.arnd@arndb.de>
	<20100819152301.GB25193@ovro.caltech.edu>
Message-ID: <201008191748.51819.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 August 2010, Ira W. Snyder wrote:
> Perhaps you were thinking of the vhost example (taken from
> drivers/vhost/Kconfig):
> 
> config VHOST_NET
>         tristate "Host kernel accelerator for virtio net (EXPERIMENTAL)"
>         depends on NET && EVENTFD && (TUN || !TUN) && (MACVTAP || !MACVTAP) && EXPERIMENTAL
> 
> They have a similar construct with both TUN and MACVTAP there. Perhaps
> the parens are a necessary part of the "X || !X" syntax? Just a random
> guess.

Yes, that's the one I was thinking of.

My mistake was that the effect is slightly different here. VHOST and TUN are
both tristate. What we guarantee here is that if TUN is "m", VHOST cannot be "y",
because its dependency cannot be fulfilled for y.

	Arnd
