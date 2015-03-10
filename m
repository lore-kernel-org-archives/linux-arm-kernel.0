From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 10 Mar 2015 12:00:49 +0000
Subject: [PATCH 1/3] arm/pmu: Reject groups spanning multiple hardware PMUs
In-Reply-To: <20150310112723.GY2896@worktop.programming.kicks-ass.net>
References: <1425905192-10509-1-git-send-email-suzuki.poulose@arm.com>
 <1425905192-10509-2-git-send-email-suzuki.poulose@arm.com>
 <20150310112723.GY2896@worktop.programming.kicks-ass.net>
Message-ID: <54FEDCF1.7020405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/15 11:27, Peter Zijlstra wrote:
> On Mon, Mar 09, 2015 at 12:46:30PM +0000, Suzuki K. Poulose wrote:
>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>
>> Don't allow grouping hardware events from different PMUs
>>   (eg. CCI + CPU).
>
> Uhm, how does this work? If we have multiple hardware PMUs we'll stop
> scheduling events after the first failed event schedule. This can leave
> one of the PMUs severely under utilized.
This is done from pmu->event_init(), where we haven't scheduled an
event yet. Do you think we need to solve it using a different approach
? What is the best way to handle this situation ? Is it OK
to allow different PMUs in the group ?

Suzuki
>
