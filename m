From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 13 Jun 2012 16:54:20 +0200
Subject: [RFC 3/4] ARM: topology: Update cpu_power according to DT
 information
In-Reply-To: <1339592856.8980.33.camel@twins>
References: <1339502524-10265-1-git-send-email-vincent.guittot@linaro.org>
 <1339502524-10265-4-git-send-email-vincent.guittot@linaro.org>
 <1339592856.8980.33.camel@twins>
Message-ID: <CAKfTPtDkRZJmfwmOeR6TPc5etbWRRneWAmN13X2_ace4wFwf7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 June 2012 15:07, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, 2012-06-12 at 14:02 +0200, Vincent Guittot wrote:
>> +struct cpu_capacity cpu_capacity[NR_CPUS];
>
> I know ARM isn't likely to suffer from the 4k cpu issue, but is there a
> reason to use a NR_CPUS array over a per-cpu variable?

At this stage, we don't know which logical CPU will match which hwid.
During the boot of each CPU, we parse the table to found an efficiency
value for the booting CPU. The whole table is used by one CPU at a
time.
