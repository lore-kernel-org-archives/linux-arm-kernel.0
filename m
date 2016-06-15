From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Jun 2016 15:51:18 +0100
Subject: [PATCH 0/5] arm/arm64: KVM: Tighten memory protection flags
In-Reply-To: <1465826449-14349-1-git-send-email-marc.zyngier@arm.com>
References: <1465826449-14349-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160615145118.GP24029@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Looks good to me. For the series:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
