From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 26 Aug 2014 16:49:37 +0200
Subject: [PATCH 03/11] KVM: ARM/arm64: avoid returning negative error
 code as bool
In-Reply-To: <1409062410-25891-4-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
 <1409062410-25891-4-git-send-email-will.deacon@arm.com>
Message-ID: <20140826144937.GA6689@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 03:13:22PM +0100, Will Deacon wrote:
> is_valid_cache returns true if the specified cache is valid.
> Unfortunately, if the parameter passed it out of range, we return
> -ENOENT, which ends up as true leading to potential hilarity.
> 
> This patch returns false on the failure path instead.
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

nice one!

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
