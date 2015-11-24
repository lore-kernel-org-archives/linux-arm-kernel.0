From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Tue, 24 Nov 2015 08:52:06 -0800
Subject: suspicious RCU usage on 4.4-rc2 ARM platform
In-Reply-To: <20151124162750.GE20439@e106622-lin>
References: <20151124162750.GE20439@e106622-lin>
Message-ID: <20151124165206.GQ26643@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 04:27:50PM +0000, Juri Lelli wrote:
> Hi Paul,
> 
> I'm hitting these splats while running simple hotplug tests on an ARM
> TC2 platform. The following seems to cure it, but I don't think it never
> made it to mainline:
> 
>  https://lkml.org/lkml/2015/5/12/892 
> 
> Any reason why?

If I remember correctly, it could result in failures on some ARM
processors.  The problem was that this patch assumes that the CPU
caches remain active throughout, when in fact they can be disabled at an
inconvenient time.  As I understand it, this can result in other updates
to that cache line being lost when the CPU is powered off.

RMK would know more.

							Thanx, Paul
