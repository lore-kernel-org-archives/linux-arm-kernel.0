From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Wed, 23 Nov 2011 16:57:31 +0100
Subject: HW perf initialisation as early_initcall
In-Reply-To: <20111123153016.GQ25848@mudshark.cambridge.arm.com>
References: <20111123145658.GM25848@mudshark.cambridge.arm.com>
 <1322060889.14799.73.camel@twins>
 <20111123153016.GQ25848@mudshark.cambridge.arm.com>
Message-ID: <1322063851.14799.77.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-23 at 15:30 +0000, Will Deacon wrote:
> We don't use this on ARM so I'm not familiar with it.
> 
NMI watchdog is basically a perf counter that fires every few seconds
and checks if the system is still making progress (much like the regular
soft watchdog stuff we have). If it thinks we're stuck it prints stack
traces to the console etc..

Handy for if you do dumb stuff like:

  local_irq_disable();
  while (1)
    ;

Which oddly enough seems to happen way too often ;-)

Anyway, it all depends on having NMIs in the first place.
