From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 Jan 2013 08:48:57 +0800
Subject: machine_is_dt() ?
In-Reply-To: <20130106131805.GQ17242@lunn.ch>
References: <20130106131805.GQ17242@lunn.ch>
Message-ID: <20130108004855.GE29281@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 06, 2013 at 02:18:05PM +0100, Andrew Lunn wrote:
> Hi Folks
> 
> I'm moving the cpuidle code for Kirkwood into drivers/cpuidle. I'm
> following the way cpuidle-calxeda.c instantiates the driver, it uses
> module_init(calxeda_cpuidle_init) and calxeda_cpuidle_init() uses
> of_machine_is_compatible("calxeda,highbank") so only loading the
> driver in a ARCH_MULTIPLATFORM kernel when needed.

A little bit off the topic, but I want to understand if moving cpuidle
driver out of arch/arm is the right direction.  From what I have seen,
more or less, cpuidle drivers generally have dependency on platform
code.  Looking at cpuidle-calxeda.c, I found though it does not include
any <mach/*> header, the following two extern declarations tell that
it actually needs to.

extern void highbank_set_cpu_jump(int cpu, void *jump_addr);
extern void *scu_base_addr;

Shawn
