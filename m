From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 10 Dec 2012 19:52:55 +0000 (UTC)
Subject: Coresight bus and drivers from CodeAurora
In-Reply-To: <20121210181840.GI12030@mudshark.cambridge.arm.com>
References: <CACRpkdYeFw3YqYqgNAKUv1U4edyzzUa9x6xBSoBU4BbBoc6q5Q@mail.gmail.com>
 <20121210181840.GI12030@mudshark.cambridge.arm.com>
Message-ID: <alpine.DEB.2.00.1212101944530.1982@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cc Alex Shishkin

Hi

On Mon, 10 Dec 2012, Will Deacon wrote:

> On Mon, Dec 10, 2012 at 12:40:20PM +0000, Linus Walleij wrote:
> > recently my colleague Magnus (@ST-Ericsson) found this bus and
> > implementations for the ARM Coresight and drivers for the ARM Coresight
> > blocks ETB, ETM, Funnel, Replicator, STM, TMC and TPIU. The
> > code is here:
> > https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git;a=tree;f=drivers/coresight;h=f0221ea9a55c1e8bcd63f36ec28abb6d5406e63d;hb=refs/heads/msm-3.4
> > 
> > What is your intention with this? Do you have any intention to mainline?

Just as an aside, there's also already some support for ETM and ETB in 
mainline in arch/arm/kernel/etm.c.

...

We've used self-hosted tracing in the past for post-mortem kernel 
debugging.  The ARM logs traces to the ETB; the kernel crashes; then upon 
the next reboot, the trace is read from the ETB.


- Paul 
