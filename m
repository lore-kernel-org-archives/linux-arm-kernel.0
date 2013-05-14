From: Benoit.Lecardonnel@synopsys.com (Benoit Lecardonnel)
Date: Tue, 14 May 2013 12:47:45 +0100
Subject: arm64: Platform devices populated from a device_initcall
In-Reply-To: <20130514093108.GA15129@arm.com>
References: <519112E7.3040309@synopsys.com> <20130514093108.GA15129@arm.com>
Message-ID: <51922461.1020408@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 2013-05-14 10:31, Catalin Marinas wrote:
> On Mon, May 13, 2013 at 05:20:55PM +0100, Benoit Lecardonnel wrote:
> I think we could put of_clk_init() and of_platform_populate() calls
> under the same arch_initcall() just to keep their relative order.
> Something like this (could even use arch_initcall_sync in case we get
> some other arch_initcall in the future)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> [...]

Thanks for the patch, it works: the device is now probed properly.

Tested-by: Benoit Lecardonnel <Benoit.Lecardonnel@synopsys.com>

-- 
Benoit Lecardonnel
