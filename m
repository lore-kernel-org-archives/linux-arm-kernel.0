From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 10 Feb 2018 17:23:06 +0100
Subject: [PATCH] drm/rockchip: Don't use spin_lock_irqsave in interrupt
 context
In-Reply-To: <20180210143501.30407-1-marc.zyngier@arm.com>
References: <20180210143501.30407-1-marc.zyngier@arm.com>
Message-ID: <1742402.LPvxsQ5ymm@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Am Samstag, 10. Februar 2018, 15:35:01 CET schrieb Marc Zyngier:
> The rockchip DRM driver is quite careful to disable interrupts
> when taking a lock that is also taken in interrupt context,
> which is a good thing.
> 
> What is a bit over the top is to use spin_lock_irqsave when
> already in interrupt context, as you cannot take another
> interrupt again, and disabling interrupt is just pure
> overhead.
> 
> Switching to the non _irqsave version in interrupt context is
> more logical, and less heavy handed.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

please note, that we had a maintainer swap for the Rockchip drm-component,
where Sandy replaced Mark [0] ... with me acting as sort-of (and not yet
up to speed) backup.

So I guess Rockchip drm patches should also include
	Sandy Huang <hjc@rock-chips.com>


Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b415b79529391abd29b6a30b93697821f01e082f
