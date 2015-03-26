From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Mar 2015 22:04:52 +0000
Subject: [PATCH 0/5] arm64: Patching branches for fun and profit
In-Reply-To: <1426773576-14062-1-git-send-email-marc.zyngier@arm.com>
References: <1426773576-14062-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150326220452.GB23836@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 01:59:31PM +0000, Marc Zyngier wrote:
> The current alternative instruction framework is not kind to branches,
> potentially leading to all kind of hacks in the code that uses
> alternatives. This series expands it to deal with immediate branches
> (for a start), and applies it to the VGIC world switch.
> 
> Patch #1 adds the required infrastructure to extract the immediate
> from an instruction.
> 
> Patch #2 allows the use of an immediate b or bl instruction as an
> alternative, computing the target branch as the instruction is being
> patched in.
> 
> Patch #3 defines a feature framework that works exactly like the CPU
> errata infrastructure (and shares a lot with it).
> 
> Patch #4 adds detection of the system register GICv3 CPU interface.
> 
> Patch #5 enables dynamic patching of the KVM code.
> 
> This has been tested with GICv3 on a FastModel.

Modulo my one minor comment:

  Acked-by: Will Deacon <will.deacon@arm.com>

for the series.

Will
