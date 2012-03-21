From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 21 Mar 2012 13:04:22 -0700
Subject: [PATCH v7 1/3] Documentation: common clk API
In-Reply-To: <20120321195656.GN3226@opensource.wolfsonmicro.com>
References: <4F6A2042.9030302@codeaurora.org>
 <20120321190741.GL3226@opensource.wolfsonmicro.com>
 <20120321193304.GO9859@atomide.com> <4F6A2EF5.3010008@codeaurora.org>
 <20120321195656.GN3226@opensource.wolfsonmicro.com>
Message-ID: <4F6A3446.9020809@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2012 12:56 PM, Mark Brown wrote:
> On Wed, Mar 21, 2012 at 12:41:41PM -0700, Saravana Kannan wrote:
>> On 03/21/2012 12:33 PM, Tony Lindgren wrote:
>>> * Mark Brown<broonie@opensource.wolfsonmicro.com>   [120321 12:11]:
>
>>>> These aren't new APIs, the clock API has been around since forever.
>
>> I disagree. When I say clock API, I mean the actual functions and
>> their semantics. Not the existence of a header file.
>
>> The meaning of clk_enable/disable has been changed and they won't
>> work without calling clk_prepare/unprepare. So, these are definitely
>> new APIs. If it weren't new APIs, then none of the general drivers
>> would need to change.
>
> clk_prepare() and clk_unprepare() are already there for any clk.h user
> and are stubbed in no matter what, they're really not a meaningful
> barrier here.

Isn't this whole experimental vs non-experimental discussion about the 
actual external facing clock APIs and not the platform driver facing APIs?

Sure, prepare/unprepare are already there in the .h file. But they are 
stubs and have no impact till we move to the common clock framework or 
platforms move to them with their own implementation (certainly not 
happening in upstream, so let's leave that part out of this discussion).

So. IMO, for all practical purposes, common clk fwk forces the move to 
these new APIs and hence IMO forces the new APIs.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
