From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Nov 2012 09:15:33 +0000
Subject: ARM: idle sleep time for hotplugged cpu
In-Reply-To: <50973842.9010708@codeaurora.org>
References: <50973842.9010708@codeaurora.org>
Message-ID: <20121105091533.GB28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 09:23:38AM +0530, Taniya Das wrote:
> I was looking at the arch/arm/process.c:cpu_die, I was wondering why we
> do not exit from NOHZ for a hotplugged/offline cpu?

Offlined CPUs are not supposed to just 'return' from cpu_die(), and
in actual fact they can't.
