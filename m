From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jan 2013 20:40:49 +0000
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <20130129174546.GE23505@n2100.arm.linux.org.uk>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <201301291636.38773.arnd@arndb.de>
 <20130129174546.GE23505@n2100.arm.linux.org.uk>
Message-ID: <201301292040.50143.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013, Russell King - ARM Linux wrote:
> Well, how it all works in the PL08x driver at present is:

<snip>

Thanks for the explanations. If I end up implementing the DT support
for pl08x, this will be very helpful. I looked at the git history
for mach-versatile and could not find any of it there, although
the patches were certainly on the mailing list
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/017818.html

Do you (or Linus) know what happened to the patch series?

Based on your description, it sounds all doable, but the split
between platform specific code and device driver code would be
different: While the muxing that you describe all takes place
in the get_signal/put_signal functions in platform code, doing
a proper DT binding for the mux would imply moving that into the
pl080 driver itself, at least as a compile-time option for the
driver. Do you think that would be acceptable?

While I guess we could still keep the get_signal/put_signal
callbacks in mach-versatile but drop them for platforms
without a mux, I'm not sure if that would make the overall
driver better or worse.

	Arnd
