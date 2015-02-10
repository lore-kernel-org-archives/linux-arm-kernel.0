From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 10 Feb 2015 20:20:36 +0000 (UTC)
Subject: [PATCHv2] ARM: omap2+: omap_hwmod: Set unique lock_class_key
 per hwmod
In-Reply-To: <1423570994-20507-1-git-send-email-peter.ujfalusi@ti.com>
References: <1423570994-20507-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <alpine.DEB.2.02.1502102020160.3767@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Feb 2015, Peter Ujfalusi wrote:

> Add struct lock_class_key to omap_hwmod struct and use it to set unique
> lockdep class per hwmod.
> This will ensure that lockdep will know that each omap_hwmod->_lock should
> be treated as separate class and will not give false warning about deadlock
> or other issues due to nested use of hwmods.
> DRA7x's ATL hwmod is one example for this since McASP can select ATL clock
> as functional clock, which will trigger nested oh->_lock usage. This will
> trigger false warning from lockdep validator as it is dealing with classes
> and for it all hwmod clocks are the same class.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks queued for v3.20-rc.


- Paul
