From: jikos@kernel.org (Jiri Kosina)
Date: Wed, 31 Oct 2018 14:19:07 +0100 (CET)
Subject: [PATCH v4 1/3] arm64: implement ftrace with regs
In-Reply-To: <20181031121002.hmag2mwvlpzwobvf@lakrids.cambridge.arm.com>
References: <20181026142008.D922868C94@newverein.lst.de>
 <20181026142148.6353A68C94@newverein.lst.de>
 <20181031121002.hmag2mwvlpzwobvf@lakrids.cambridge.arm.com>
Message-ID: <nycvar.YFH.7.76.1810311417361.30233@cbobk.fhfr.pm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Oct 2018, Mark Rutland wrote:

> I guess skipping the original function prologue would simplify the
> implementation of the replacement function (and would mean that the regs
> held the function arguments per the procedure call standard), but AFAICT
> other architectures aren't relying on that, so it doesn't seem to be a
> strict requirement.
> 
> What am I missing?
> 
> How does livepatching handle the pre-mcount function preambles on
> architectures with existing support?

Other architectures do rely on that. That's exactly for example why on x86 
we use '-pg -mfentry', to make sure we hook the function *before* 
prologue.

Thanks,

-- 
Jiri Kosina
SUSE Labs
