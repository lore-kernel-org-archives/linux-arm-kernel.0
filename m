From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 25 Sep 2015 17:09:12 +0100
Subject: [PATCH] arm-cci500: Workaround pmu_event_set_period
In-Reply-To: <20150925160546.GQ21513@n2100.arm.linux.org.uk>
References: <1443196253-22765-1-git-send-email-suzuki.poulose@arm.com>
 <20150925160546.GQ21513@n2100.arm.linux.org.uk>
Message-ID: <560571A8.6050002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/09/15 17:05, Russell King - ARM Linux wrote:
> As you're posting an update to CCI500, I thought I'd hijack this
> thread to complain about the same thing that I complained about
> with CCI400:
>
> +config ARM_CCI500_PMU
> +       bool "ARM CCI500 PMU support"
> +       default y
> +       depends on (ARM && CPU_V7) || ARM64
> +       depends on PERF_EVENTS
> +       select ARM_CCI_PMU
>
> Why "default y" ?  Not all ARMv7 CPUs have the CCI bus, and what it
> means is that when moving forward, it's a pain to remember to turn
> the option off amongst all the other Kconfig questions.
>
> Only make things "default y" if it was something that was built in
> a previous kernel and not building it in a later kernel would cause
> a regression, or where it's absolutely necessary to do so.

Sure, we can turn that off by default. I will send a patch.

Suzuki
