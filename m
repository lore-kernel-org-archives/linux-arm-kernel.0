From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 10:25:27 +0100
Subject: BUG: commit "ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
 pre-ARMv6 CPUs" breaks armv5 with CONFIG_PREEMPT
In-Reply-To: <51C2C0B5.8020802@pengutronix.de>
References: <51C2C0B5.8020802@pengutronix.de>
Message-ID: <20130620092527.GD2842@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Thu, Jun 20, 2013 at 09:43:33AM +0100, Marc Kleine-Budde wrote:
> The problem can be reproduced on several mx28 and an at91sam9263 and
> only occurs of CONFIG_PREEMPT (Preemptible Kernel (Low-Latency Desktop))
> is enabled.
> 
> I have the gut feeling that the "if (irqs_disabled())" check in the
> above patch is not correct for CONFIG_PREEMPT.
> 
> Marc
> 
> [1] The test program creating 150 threads in a row crashes like this:
> > [8]+  Segmentation fault         ./thread_test_c
> > [5]   Illegal instruction        ./thread_test_c
> > [4]   Illegal instruction        ./thread_test_c
> > [2]   Segmentation fault         ./thread_test_c
> > [3]   Illegal instruction        ./thread_test_c
> > [1]   Segmentation fault         ./thread_test_c

Any chance you can make your test available somewhere please? I remember
testing on a 926 when the patch was written, so it could be a bad
interaction with some later changes.

Cheers,

Will
