From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 29 Jun 2016 14:21:18 +0200
Subject: [PATCH 0/5] arm/arm64: KVM: Tighten memory protection flags
In-Reply-To: <1465826449-14349-1-git-send-email-marc.zyngier@arm.com>
References: <1465826449-14349-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160629122118.GU26498@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Mon, Jun 13, 2016 at 03:00:44PM +0100, Marc Zyngier wrote:
> So far, the HYP mappings have been fairly relaxed: everything is
> RWX. Oddly enough, not everybody is fond of this kind of permissions
> at the highest exception level.
> 
> This small series tightens it a bit by making:
> - the text mapping read-only
> - the rodata mapping read-only + no-exec
> - everything else read-write + no-exec
> 
> Of course, that's only valid when VHE is not in action. Tested on
> Seattle and Cubietruck, based on 4.7-rc2.
> 

I have applied this to queue with a RB on all the patches.

It seems like this series applies on top of the merged page tables
stuff, but since I think you're going to repost that, I have just
applied this and fixed up the conflicts.

Could you have a look at kvmarm/queue and let me know if you think it
looks good?  (and possibly rebase the merge page tables stuff on top of
there when you rework that series?)

Thanks!
-Christoffer
