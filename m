From: gengdongjiu@huawei.com (gengdongjiu)
Date: Mon, 16 Jul 2018 11:00:10 +0800
Subject: [PATCH v8 4/4] KVM: arm: Add 32bit get/set events support
In-Reply-To: <20180713154751.18131-5-james.morse@arm.com>
References: <20180713154751.18131-1-james.morse@arm.com>
 <20180713154751.18131-5-james.morse@arm.com>
Message-ID: <bb946622-4835-133a-d70d-d3a4e360319d@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018/7/13 23:47, James Morse wrote:
> arm64's new use of KVMs get_events/set_events API calls isn't just
> for RAS, it allows an SError that has been made pending by KVM as
> part of its device emulation to be migrated.
> 
> Wire this up for 32bit too.
> 
> We only need to read/write the HCR_VA bit, and check that no esr has
> been provided, as we don't yet support VDFSR.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> CC: Dongjiu Geng <gengdongjiu@huawei.com>

Thanks!
Reviewed-by: Dongjiu Geng <gengdongjiu@huawei.com>

> ---
> Changes since v7:
>  * Removed temporary #ifdefs
>  * Added 'and 32bit' to the the documentation.
> ---
>  Documentation/virtual/kvm/api.txt |  8 ++++----
>  arch/arm/include/asm/kvm_host.h   |  5 +++++
