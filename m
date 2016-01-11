From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 11 Jan 2016 18:12:34 +0000
Subject: [PATCH v5 05/11] arm-cci PMU: Delay counter writes to pmu_enable
In-Reply-To: <20160111112443.GI6499@leverpostej>
References: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
 <1451908490-2615-6-git-send-email-suzuki.poulose@arm.com>
 <20160104192401.GD17127@leverpostej> <568B93F1.8050202@arm.com>
 <20160111104609.GE6499@leverpostej> <56938D2B.7050700@arm.com>
 <20160111112443.GI6499@leverpostej>
Message-ID: <5693F092.3080209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/16 11:24, Mark Rutland wrote:
> On Mon, Jan 11, 2016 at 11:08:27AM +0000, Suzuki K. Poulose wrote:
>> On 11/01/16 10:46, Mark Rutland wrote:
>>> On Tue, Jan 05, 2016 at 09:59:13AM +0000, Suzuki K. Poulose wrote:
>>>> On 04/01/16 19:24, Mark Rutland wrote:
>> Hence, didn't want to change it for CCI. We could use the batching
>> logic, if decide to do so. I can go ahead with that if there are no
>> other side effects with that.
>
> We'll lose events regardless as our RMW sequence will race against the
> counters. Batching will make that window slightly larger, but other than
> that I don't see a problem.

OK, will do that.

Cheers
Suzuki
