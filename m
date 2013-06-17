From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jun 2013 09:26:03 +0100
Subject: [PATCH v5] arm: Preserve the user r/w register TPIDRURW on
 context switch and fork
In-Reply-To: <51B22F01.3030905@arm.com>
References: <519D32E2.5050102@dawncrow.de> <51B22F01.3030905@arm.com>
Message-ID: <20130617082603.GA2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 08:05:37PM +0100, Jonathan Austin wrote:
> The next step is to put it in to Russell's patch system. This is the way  
> Russell manages (small/non-pull-request) things that need to go in to  
> his tree.

And I'm going to drop this patch:

arch/arm/kernel/entry-armv.S:692: Error: selected processor does not support ARM mode `ldrd r4,r5,[r2,#96]'

LDRD is not supported on all the CPUs we have...
