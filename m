From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 May 2014 09:01:52 +0100
Subject: [PATCH RESEND] ARM: kdump: 2nd kernel should use strict
 pfn_valid in SPARSEMEM platform
In-Reply-To: <5386BD6A.7020509@linaro.org>
References: <1401266668-34365-1-git-send-email-wangnan0@huawei.com>
 <5386BD6A.7020509@linaro.org>
Message-ID: <20140529080151.GB29812@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 29, 2014 at 05:54:02AM +0100, AKASHI Takahiro wrote:
> Catalin, Will
> 
> Can we assume that HAVE_ARCH_PFN_VALID is alway yes on arm64?
> Looking at arm64/Kconfig,
> config ARCH_HAS_HOLES_MEMORYMODEL
> 	def_bool y if SPARSEMEM
> ...
> config HAVE_ARCH_PFN_VALID
> 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
> 
> is this intentional?

Looks like an artifact of the way we constructed those option, so yes, we
could just make that a def_bool y if you like.

Will
