From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 16 Jun 2011 15:48:48 +0200
Subject: [RFC] Add Arm cpu topology definition
In-Reply-To: <20110616132441.GJ14846@anthem.async.com.br>
References: <BANLkTinRGRUxKB=C_2Y2F93czWScEUo+Jw@mail.gmail.com>
	<20110616132441.GJ14846@anthem.async.com.br>
Message-ID: <BANLkTi=zZsArjjEUoB=w-_1JxyMEr-KK_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 June 2011 15:24, Christian Robottom Reis <kiko@linaro.org> wrote:
> On Thu, Jun 16, 2011 at 10:49:13AM +0200, Vincent Guittot wrote:
>> @@ -219,6 +219,24 @@ source "kernel/Kconfig.freezer"
>>
>> ?menu "System Type"
>>
>> +config SCHED_MC
>> + ? ? bool "Multi-core scheduler support"
>> + ? ? depends on SMP && ARM_CPU_TOPOLOGY
>> + ? ? default n
>> + ? ? help
>> + ? ? ? Multi-core scheduler support improves the CPU scheduler's decision
>> + ? ? ? making when dealing with multi-core CPU chips at a cost of slightly
>> + ? ? ? increased overhead in some places. If unsure say N here.
>> +
>> +config SCHED_SMT
>> + ? ? bool "SMT scheduler support"
>> + ? ? depends on SMP && ARM_CPU_TOPOLOGY
>> + ? ? default n
>> + ? ? help
>> + ? ? ? Improves the CPU scheduler's decision making when dealing with
>> + ? ? ? MultiThreading at a cost of slightly increased overhead in some
>> + ? ? ? places. If unsure say N here.
>> +
>
> Quick question: the patch doesn't actually seem to use the SCHED_MC and
> SCHED_SMT config bits; is that actually correct?

The default config of the patch is to disable sched_mc and sched_smt.
The 1st goal is to let each platform enable and test the feature.
According to feedback, we could then change the default state of the
configuration

> --
> Christian Robottom Reis ? | [+55] 16 9112 6430 | http://launchpad.net/~kiko
> Linaro Engineering VP ? ? | [ +1] 612 216 4935 | http://async.com.br/~kiko
>
