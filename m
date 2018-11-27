From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Nov 2018 19:44:45 +0000
Subject: [PATCH 0/2] use adrp/add pairs for PLT entries
In-Reply-To: <20181122084646.3247-1-ard.biesheuvel@linaro.org>
References: <20181122084646.3247-1-ard.biesheuvel@linaro.org>
Message-ID: <20181127194444.GK5641@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Thu, Nov 22, 2018 at 09:46:44AM +0100, Ard Biesheuvel wrote:
> Currently, PLT entries use a non-idiomatic movn/movz/movz/br instruction
> sequence which is also longer than necessary. Also, the code emitting
> them does not use the instruction generation code but open codes the
> opcodes directly.
> 
> The extended KASLR range is now 4 GB, given that we switched to the
> small code model everywhere else (including for modules), so we can
> switch to adrp/add/br sequences which are easier in the I-cache.
> 
> So implement adrp/add pair generation in the instruction generation code
> and wire it up into the PLT code. Note that the Cortex-A53 errata handling
> requires some special care to ensure that generated veneers are not
> susceptible to the erratum.
> 
> Cc: Torsten Duwe <duwe@lst.de>
> Cc: Jessica Yu <jeyu@kernel.org>

I've applied this, with a couple of extra comments in the plt comparison
code and the Reviewed-by from Torsten. There were some trivial conflicts
with Jessica's rework of the plt lookup, but I think I got it right. Please
take a look at for-next/core when you get a chance.

Will
