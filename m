From: will.deacon@arm.com (Will Deacon)
Date: Fri, 14 Oct 2011 10:31:01 +0100
Subject: Warning in -next w/ "ARM: 7011/1: Add ARM cpu topology definition"
Message-ID: <20111014093100.GA23994@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

When compiling next with SCHED_MC enabled I get a warning from sched.c
because your topology functions (declared in arch/arm/include/asm/topology.h)
take unsigned int cpu rather than int cpu:

kernel/sched.c:7354:2: warning: initialization from incompatible pointer type

7353 #ifdef CONFIG_SCHED_MC
7354         { sd_init_MC, cpu_coregroup_mask, },
7355 #endif

Apologies if you've already got a fix queued for this,

Will
