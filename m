From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 2 Aug 2011 21:58:21 +0900
Subject: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <s5hy5zcnlu8.wl%tiwai@suse.de>
References: <1312198690-13237-1-git-send-email-b29396@freescale.com>
	<20110801115150.GB16629@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F410B@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110802083850.GB9553@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F427D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hy5zcnlu8.wl%tiwai@suse.de>
Message-ID: <20110802125819.GA25884@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2011 at 12:34:23PM +0200, Takashi Iwai wrote:

> reg_cache_size is supposed to be the real size of the cache table.
> This isn't influenced by reg_cache_step value.  So, the behavior in
> soc-io.c (and other ASoC core) is correct.

> That is, the codec drivers setting ARRAY_SIZE() to reg_cache_size
> with reg_cache_step > 1 are buggy and should be fixed.

Yes, that's probably the best spot fix - I think it should work.  But
of course really all this code is bit rotten and should be refactored to
be more comprehensible so nobody has to worry if it's doing the right
thing.
