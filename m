From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Apr 2013 12:04:23 +0100
Subject: [alsa-devel] [PATCH 20/30] ASoC: samsung: convert to dmaengine API
In-Reply-To: <5168601F.2070409@metafoo.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-21-git-send-email-arnd@arndb.de>
 <20130411142706.GB24971@opensource.wolfsonmicro.com>
 <201304111647.17796.arnd@arndb.de> <5168601F.2070409@metafoo.de>
Message-ID: <20130415110422.GA15837@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 09:27:27PM +0200, Lars-Peter Clausen wrote:

> I actually had a look at how the Samsung PCM driver a couple of days back,
> but I didn't fully grasp how things work with the secondary TX channel for
> the i2s driver and to make it work with the generic dmaengine PCM driver.
> The code handling this in the i2s driver seems to be rather messy with lots
> of ifs and elses. Also things would have would be a lot easier if the dt
> bindings had used two subnodes each with their own 'dmas' property.

Yeah, it's quite messy at the minute as it predates any subsystem
support for things like multiple DMA channels going into a single DAI on
an AP so it was having to do things it really shouldn't have done.  What
ought to happen is that the driver gets refactored to use soc-pcm or
change to represent the mixer block as a CODEC, I think if that happens
then things ought to get easier.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130415/53099be0/attachment.sig>
