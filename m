From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 1 Aug 2014 14:04:44 +0200
Subject: [PATCH] arm64: KVM: fix 64bit CP15 VM access for 32bit guests
In-Reply-To: <1406890836-7294-1-git-send-email-marc.zyngier@arm.com>
References: <1406890836-7294-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140801120444.GM11610@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 12:00:36PM +0100, Marc Zyngier wrote:
> Commit f0a3eaff71b8 (ARM64: KVM: fix big endian issue in
> access_vm_reg for 32bit guest) changed the way we handle CP15
> VM accesses, so that all 64bit accesses are done via vcpu_sys_reg.
> 
> This looks like a good idea as it solves indianness issues in an
> elegant way, except for one small detail: the register index is
> doesn't refer to the same array! We end up corrupting some random
> data structure instead.

Ouch!

> 
> Fix this by reverting to the original code, except for the introduction
> of a vcpu_cp15_64_high macro that deals with the endianness thing.
> 
> Tested on Juno with 32bit SMP guests.
> 
> Cc: Victor Kamensky <victor.kamensky@linaro.org>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Christoffer, can you please have a look at this one and and queue it if
> you find it acceptable?
> 

Good catch, it looks good, I'll queue it on kvmarm/next right away.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

-Christoffer
