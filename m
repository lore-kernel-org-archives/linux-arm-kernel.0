From: pkluba@dension.com (Patrik, Kluba)
Date: Tue, 8 Jan 2013 12:51:14 +0100
Subject: [PATCH 01/01] arm: fix a preempt_count() corruption for
 CONFIG_PREEMPT=n
In-Reply-To: <50E755FA.8040609@codeaurora.org>
References: <20121215085129.71d203b2.pkluba@dension.com>
 <50D10224.30600@codeaurora.org>
 <20121219000139.GV14363@n2100.arm.linux.org.uk>
 <50E4D39C.1030001@codeaurora.org>
 <20130104084850.4553bc6f.pkluba@dension.com>
 <50E755FA.8040609@codeaurora.org>
Message-ID: <20130108125114.2292c2bb.pkluba@dension.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 04 Jan 2013 14:21:46 -0800
Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 01/03/13 23:48, Patrik, Kluba wrote:
> > Sorry for being late, was on holiday. Yes, you were right,
> > CONFIG_DEBUG_PREEMPT (after breaking dependency on CONFIG_PREEMPT -
> > this is how I caught the exact place) and CONFIG_DEBUG_ATOMIC_SLEEP
> > was enabled due to bug hunting in own code (and found yet another
> > at an unexpected place). 
> > I have chosen #ifdef CONFIG_PREEMPT to match with assembly code, but
> > your solution seems more reasonable.
> 
> Did you test my patch? If so, can I get your tested by please so I can
> stick it in the patch tracker?

Yes, I have tested it. Here you are:

Tested-by: Patrik Kluba <pkluba@dension.com>

Bye,
Patrik
