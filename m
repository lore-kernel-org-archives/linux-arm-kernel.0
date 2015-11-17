From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 17 Nov 2015 11:56:02 +0800
Subject: [Query] How to measure the entry-latency-us and exit-latency-us
 on arm PSCI system
In-Reply-To: <20151116160513.GB19228@red-moon>
References: <20151116201055.00567e90@xhacker> <20151116160513.GB19228@red-moon>
Message-ID: <20151117115602.6f3626be@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Nov 2015 16:05:13 +0000
Lorenzo Pieralisi wrote:

> On Mon, Nov 16, 2015 at 08:10:55PM +0800, Jisheng Zhang wrote:
> > Hi all,
> > 
> > Now, I'd like to add cpuidle support to Marvell berlin arm64 soc via
> > drivers/cpuidle/dt_idle_states.c. The system is PSCI-1.0 compatible. 
> > 
> > Per my understanding:
> > 
> > The entry-latency-us: the time from beginning of cpuidle_idle_call()
> > to the firmware's last WFI instruction. Should test more times to find
> > the longest time.
> > 
> > The exit-latency-us: the time from the first instruction of waken up cpu
> > to the end of cpuidle_idle_call(). Should test more times to find the longest
> > time.
> > 
> > If cpufreq is available, we should fix the cpufreq to the lowest freq to do
> > the above test.
> > 
> > Even I have a look at idle-states binding doc, I'm still not sure whether my
> > solution to measure the entry-latency-us and exit-latency-us is correct or not,
> > could you please give suggestions?  
> 
> It is correct and yes for the time being they represent the global worst
> case so your assumption on cpufreq is reasonable, you should set the
> system in the worst case conditions.
> 
> If the entry phase is interruptible on pending irq (which means that
> your firmware has checkpoints in the power down sequence) please define
> wakeup-latency according to the docs, it might be < entry+exit,
> otherwise your measurements are just fine.
> 

Got it. Thanks for detailed explanations
