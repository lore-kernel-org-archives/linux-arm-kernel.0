From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Aug 2013 10:11:00 +0100
Subject: [PATCH v4] ARM: Add check for Cortex-A15 errata 798181 ECO
In-Reply-To: <1377440747-4564-1-git-send-email-robherring2@gmail.com>
References: <1377440747-4564-1-git-send-email-robherring2@gmail.com>
Message-ID: <20130830091100.GC25628@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 25, 2013 at 03:25:47PM +0100, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> The work-around for A15 errata 798181 is not needed if appropriate ECO
> fixes have been applied to r3p2 and earlier core revisions. This can be
> checked by reading REVIDR register bits 4 and 9. If only bit 4 is set,
> then the IPI broadcast can be skipped.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
> v4:
> - Move code from setup.c back to smp_tlb.c
> - Use IS_ENABLED macro

Reviewed-by: Will Deacon <will.deacon@arm.com>

Note that you might get some trivial conflicts with my barriers series,
which is merged in rmk/devel-stable (and therefore -next).

Will
