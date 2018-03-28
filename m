From: james.morse@arm.com (James Morse)
Date: Wed, 28 Mar 2018 17:33:30 +0100
Subject: [PATCH v2 08/11] firmware: arm_sdei: Add ACPI GHES registration
 helper
In-Reply-To: <201803250913.XCBc2k7m%fengguang.wu@intel.com>
References: <20180322181445.23298-9-james.morse@arm.com>
 <201803250913.XCBc2k7m%fengguang.wu@intel.com>
Message-ID: <590e2665-4471-8795-675e-28d103e1a103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi kbuild test robot,

On 25/03/18 02:41, kbuild test robot wrote:
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on v4.16-rc6]
> [cannot apply to arm64/for-next/core next-20180323]

This is the potential conflict I referred to in v1's cover letter...


> All errors (new ones prefixed by >>):
> 
>    drivers//firmware/arm_sdei.c: In function 'sdei_register_ghes':
>>> drivers//firmware/arm_sdei.c:921:26: error: 'FIX_APEI_GHES_SDEI_CRITICAL' undeclared (first use in this function)
>       ghes->nmi_fixmap_idx = FIX_APEI_GHES_SDEI_CRITICAL;

Looks like I forgot to include asm/fixmap.h! I hate header-soup.


Thanks,

James
