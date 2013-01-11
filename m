From: olof@lixom.net (Olof Johansson)
Date: Fri, 11 Jan 2013 12:18:50 -0800
Subject: arm: mvebu: Fix compile for multiplatform when ARMv6 is selected
In-Reply-To: <20130111200531.GO14149@atomide.com>
References: <20130111200531.GO14149@atomide.com>
Message-ID: <20130111201850.GA20524@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 12:05:31PM -0800, Tony Lindgren wrote:
> Some systems compile in both ARMv6 and ARMv7 into multiplatform
> configurations. This means the default compiler flags are for ARMv6,
> and we will get:
> 
> arch/arm/mach-mvebu/coherency_ll.S: Assembler messages:
> arch/arm/mach-mvebu/coherency_ll.S:45: Error: selected processor does not support `dsb'
> 
> Fix this by specifying ARMv7 flags for coherency_ll.o.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied to fixes, I don't expect Jason or others to complain about this
so I took the liberty. :)


-Olof
