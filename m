From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 23 Jan 2018 15:11:36 +0000
Subject: [PATCH 02/16] arm64: Move errata work around check on boot CPU
In-Reply-To: <31e6c173-9c27-80fd-a24e-8d234bb4be01@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-3-suzuki.poulose@arm.com>
 <20180123145934.GS22781@e103592.cambridge.arm.com>
 <31e6c173-9c27-80fd-a24e-8d234bb4be01@arm.com>
Message-ID: <20180123151135.GT22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 03:07:18PM +0000, Suzuki K Poulose wrote:
> On 23/01/18 14:59, Dave Martin wrote:
> >On Tue, Jan 23, 2018 at 12:27:55PM +0000, Suzuki K Poulose wrote:
> >>We trigger CPU errata work around check on the boot CPU from
> >>smp_prepare_boot_cpu() to make sure that we run the checks only
> >>after the CPU feature infrastructure is initialised.
> >
> >On the surface of it, this sounds like a bug fix.
> 
> No, this is not. It is just moving the code to cpufeature.c
> 
> Earlier it was :
> 
> smp_prepare_boot_cpu()  -> cpuinfo_store_boot_cpu() -> init_cpu_features()
> 
> and then we did update_cpu_errata_workarounds() after we have done
> cpuinfo_store_boot_cpu(). With this change we do :
> 
> smp_prepare_boot_cpu()  -> cpuinfo_store_boot_cpu() -> init_cpu_features() -> update_cpu_errata_workarounds()
> 
> 
> >
> >Should there be a Fixes tag if so?
> >
> >If this reordering doesn't matter for upstream, it would be good to have
> >a quick explanation here as to why not.
> 
> Sure, will make it clearer.

Fair enough -- thanks.

I was a bit sketchy on the exact code flow here.

[...]

Cheers
---Dave
