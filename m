From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 10 Feb 2016 13:44:28 +0100
Subject: [PATCH 1/8] arm64: KVM: Switch the sys_reg search to be a binary
 search
In-Reply-To: <1454931622-14902-2-git-send-email-marc.zyngier@arm.com>
References: <1454931622-14902-1-git-send-email-marc.zyngier@arm.com>
 <1454931622-14902-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160210124428.GH5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 11:40:15AM +0000, Marc Zyngier wrote:
> Our 64bit sys_reg table is about 90 entries long (so far, and the
> PMU support is likely to increase this). This means that on average,
> it takes 45 comparaisons to find the right entry (and actually the
> full 90 if we have to search the invariant table).
> 
> Not the most efficient thing. Specially when you think that this
> table is already sorted. Switching to a binary search effectively
> reduces the search to about 7 comparaisons. Slightly better!
> 
> As an added bonus, the comparaison is done by comparing all the

s/comparaison/comparison/

> fields at once, instead of one at a time.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
