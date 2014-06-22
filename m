From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 22 Jun 2014 12:27:24 +0100
Subject: [RFC PATCH 3/6] arm/arm64: KVM: vgic: Clear queued flags on
 unqueue
In-Reply-To: <1402779067-34478-4-git-send-email-christoffer.dall@linaro.org>
References: <1402779067-34478-1-git-send-email-christoffer.dall@linaro.org>
 <1402779067-34478-4-git-send-email-christoffer.dall@linaro.org>
Message-ID: <c0a73d217307bedefb2f01ec3a653f9f@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-06-14 21:51, Christoffer Dall wrote:
> If we unqueue a level-triggered interrupt completely, and the LR does
> not stick around in the active state (and will therefore no longer
> generate a maintenance interrupt), then we should clear the queued 
> flag
> so that the vgic can actually queue this level-triggered interrupt at 
> a
> later time and deal with its pending state then.
>
> Note: This should actually be properly fixed to handle the active 
> state
> on the distributor.
>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

With the previous remark about queued/resample in mind,

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

         M.
-- 
Fast, cheap, reliable. Pick two.
