From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jul 2011 14:27:21 +0100
Subject: [PATCH 3.0] fix compile warnings in plat-iop/cp6.c
In-Reply-To: <20009.28803.497535.598471@pilspetsen.it.uu.se>
References: <20009.28803.497535.598471@pilspetsen.it.uu.se>
Message-ID: <20110722132721.GA25947@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 02:43:47PM +0200, Mikael Pettersson wrote:
> Building 3.0 for an n2100 (plat-iop) results in:
> 
> In file included from arch/arm/plat-iop/cp6.c:20:
> /tmp/linux-3.0/arch/arm/include/asm/traps.h:12: warning: 'struct pt_regs' declared inside parameter list
> /tmp/linux-3.0/arch/arm/include/asm/traps.h:12: warning: its scope is only this definition or declaration, which is probably not what you want
> /tmp/linux-3.0/arch/arm/include/asm/traps.h:48: warning: 'struct pt_regs' declared inside parameter list
> /tmp/linux-3.0/arch/arm/include/asm/traps.h:48: warning: 'struct task_struct' declared inside parameter list
> arch/arm/plat-iop/cp6.c:45: warning: initialization from incompatible pointer type
> 
> The pt_regs and incompatible pointer type warnings are fixed by including
> <asm/ptrace.h> before <asm/traps.h>.  Nothing here depends on task_struct,
> so that warning can be fixed by a forward struct declaration.

Why not add a forward declaration of struct pt_regs and task_struct
to asm/traps.h ?
