From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 18 Dec 2015 10:28:23 +0000
Subject: [PATCH v4 05/12] arm-cci: PMU: Add support for transactions
In-Reply-To: <20151217184255.GI6344@twins.programming.kicks-ass.net>
References: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
 <1450374559-23315-6-git-send-email-suzuki.poulose@arm.com>
 <20151217184255.GI6344@twins.programming.kicks-ass.net>
Message-ID: <5673DFC7.6060406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/12/15 18:42, Peter Zijlstra wrote:
> On Thu, Dec 17, 2015 at 05:49:12PM +0000, Suzuki K. Poulose wrote:
>> We keep track of only the 'ADD' transactions. While we are in a
>> transaction, we keep track of the indices allocated for the events
>> and delay the following operations until the transaction is committed.
>>   1) Programming the event on the counter
>>   2) Enabling the counter
>>   3) Setting the period for the event.
>
> So that's not really what the txn interface is for, its meant to
> amortize event scheduling.

OK

>
> The above doesn't look like it has a failure case, in which case you can
> achieve the same simpler, using pmu::pmu_{dis,en}able().
>

I thought about that, but was not sure if pmu->stop() is guaranteed to be
called on all the events scheduled on the PMU when we pmu::pmu_disable().
Is it ?

Thanks for the quick response.

Suzuki
