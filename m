From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Dec 2012 18:56:18 +0100
Subject: [PATCH] cpuidle: kirkwood: Move out of mach directory, add DT.
In-Reply-To: <50DDDBEB.3000002@ti.com>
References: <1356698844-4220-1-git-send-email-andrew@lunn.ch>
 <50DDAA42.2020101@gmail.com> <20121228143517.GA5172@lunn.ch>
 <50DDB2E3.103@gmail.com> <20121228154927.GC5172@lunn.ch>
 <50DDC54A.3020509@gmail.com> <50DDCF47.1030305@ti.com>
 <20121228172807.GA7578@lunn.ch> <50DDDBEB.3000002@ti.com>
Message-ID: <20121228175618.GC7578@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Is this single CPU or multi-cpu machine ?

Its a uniprocessor.

> Even though the cpu_do_idle()
> has just couple of instructions, there can be lot more happening in
> background especially with multi masters system. It might be safe if the
> single CPU is the only master accessing DDR. In multi-master, multi-CPU
> scenario though it can't work reliably.

There are DMA engines which could be active, moving stuff into/out of
memory.

Having said that, this code is not new, it is just getting a new home.
There has not been problems before. Having this 256 cycle delay etc,
suggests the hardware design is robust.

	 Andrew
