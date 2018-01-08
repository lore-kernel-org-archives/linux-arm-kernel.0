From: james.morse@arm.com (James Morse)
Date: Mon, 08 Jan 2018 16:27:13 +0000
Subject: [PATCH v5 13/13] KVM: arm64: Emulate RAS error registers and
 set HCR_EL2's TERR & TEA
In-Reply-To: <20171215155101.23505-14-james.morse@arm.com>
References: <20171215155101.23505-1-james.morse@arm.com>
 <20171215155101.23505-14-james.morse@arm.com>
Message-ID: <5A539BE1.20003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15/12/17 15:51, James Morse wrote:
> From: Dongjiu Geng <gengdongjiu@huawei.com>
> 
> ARMv8.2 adds a new bit HCR_EL2.TEA which routes synchronous external
> aborts to EL2, and adds a trap control bit HCR_EL2.TERR which traps
> all Non-secure EL1&0 error record accesses to EL2.
> 
> This patch enables the two bits for the guest OS, guaranteeing that
> KVM takes external aborts and traps attempts to access the physical
> error registers.
> 
> ERRIDR_EL1 advertises the number of error records, we return
> zero meaning we can treat all the other registers as RAZ/WI too.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> [removed specific emulation, use trap_raz_wi() directly for everything,
>  rephrased parts of the commit message]
> Signed-off-by: James Morse <james.morse@arm.com>

v4 of this patch had a Reviewed-by Marc and Christoffer, which I didn't pick up
because I'm an idiot:

https://patchwork.kernel.org/patch/10017537/


Thanks,

James
