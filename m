From: afzal@ti.com (Mohammed, Afzal)
Date: Fri, 15 Jun 2012 06:16:12 +0000
Subject: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E99A28B@DBDE01.ent.ti.com>
References: <20120613113217.GK12766@atomide.com>
 <20120613115445.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998C80@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999849@DBDE01.ent.ti.com>
 <20120614101901.GI12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99994C@DBDE01.ent.ti.com>
 <20120614115207.GL12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999AA4@DBDE01.ent.ti.com>
 <20120614122930.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999C13@DBDE01.ent.ti.com>
 <20120614165337.GO12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99A28B@DBDE01.ent.ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99A2C4@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Fri, Jun 15, 2012 at 11:12:46, Mohammed, Afzal wrote:

> But I am unable to find reason for failure upon using
> gpmc_ticks_to_ns(1), which seems to me right thing to be used.
> Let me try to invoke tusb6010 functions in beagle board,
> observe timings so that at least I will get an idea
> what is going on here (even though it is guaranteed to crash)

Checked simulating on beagle board, I am at total loss to
understand why using gpmc_ticks_to_ns(1) has failed for n8x0

clk_activation timings with both values as follows,
 
[1] With t.clk_activation = gpmc_ticks_to_ns(1);

GPMC CS4: clk_activation:   1 ticks,   6 ns (was   0 ticks)   6 ns

[2] With t.clk_activation = 1;

GPMC CS4: clk_activation:   1 ticks,   6 ns (was   0 ticks)   1 ns

Last field show in ns the time we are trying to set,
and for both cases, 1 ticks are being programmed in register.

Regards
Afzal 
