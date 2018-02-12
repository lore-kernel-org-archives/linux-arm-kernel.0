From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 12 Feb 2018 09:28:41 +0000
Subject: [PATCH] drm/rockchip: Don't use spin_lock_irqsave in interrupt
 context
In-Reply-To: <1742402.LPvxsQ5ymm@phil>
References: <20180210143501.30407-1-marc.zyngier@arm.com>
 <1742402.LPvxsQ5ymm@phil>
Message-ID: <806e60b7-1fa1-3055-e66e-84645d20f442@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 10/02/18 16:23, Heiko Stuebner wrote:
> Hi Marc,
> 
> Am Samstag, 10. Februar 2018, 15:35:01 CET schrieb Marc Zyngier:
>> The rockchip DRM driver is quite careful to disable interrupts
>> when taking a lock that is also taken in interrupt context,
>> which is a good thing.
>>
>> What is a bit over the top is to use spin_lock_irqsave when
>> already in interrupt context, as you cannot take another
>> interrupt again, and disabling interrupt is just pure
>> overhead.
>>
>> Switching to the non _irqsave version in interrupt context is
>> more logical, and less heavy handed.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> please note, that we had a maintainer swap for the Rockchip drm-component,
> where Sandy replaced Mark [0] ... with me acting as sort-of (and not yet
> up to speed) backup.
> 
> So I guess Rockchip drm patches should also include
> 	Sandy Huang <hjc@rock-chips.com>

I guess that update didn't make it into 4.15, which is why I didn't spot
it. I'll repost the patches shortly including Sandy on Cc.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
