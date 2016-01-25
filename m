From: johannes@sipsolutions.net (Johannes Berg)
Date: Mon, 25 Jan 2016 11:43:38 +0100
Subject: [PATCH 1/2] arm/mach-imx: use endian-safe
 readl/readw/writel/writew
In-Reply-To: <27961664.oTCXiXao1R@wuerfel>
References: <1453651346-12760-1-git-send-email-johannes@sipsolutions.net>
 <27961664.oTCXiXao1R@wuerfel>
Message-ID: <1453718618.2164.2.camel@sipsolutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2016-01-24 at 22:28 +0100, Arnd Bergmann wrote:
>?
> The patch looks fine to me, in the sense that we can safely assume
> that the behavior won't change for little-endian, and that it is
> fixing a bug for big-endian.
> 
> I would feel more comfortable with a patch using the non-relaxed()
> accessors though, as that can avoid a number of subtle bugs with
> I/O ordering.

I could easily generate this, obviously, the spatch was above :)

> Unfortunately, there is a nonzero overhead in the extra cache sync
> on the Cortex-A9 based platforms (most imx6), so this has to
> be done very carefully to avoid performance regressions. It's
> probably a good idea to keep the two changes as separate commits,
> but I'd also like to get both applied in the same merge window,
> as 'readl_relaxed' tends to say "I have proven that I don't need
> barriers", while the existing code just screams "I have no idea
> about what I'm doing here".

So does my patch, and I'm not sure I'm qualified to really judge which
ones need to be relaxed for performance reasons and which ones should
be changed.


johannes
