From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 9 Oct 2014 09:21:01 +0200
Subject: [PATCH v2 0/8] Per-user clock constraints
In-Reply-To: <5435E5B0.90900@codeaurora.org>
References: <1412695334-2608-1-git-send-email-tomeu.vizoso@collabora.com>
 <5435E5B0.90900@codeaurora.org>
Message-ID: <CAAObsKBZ8irmk0fdEQUvT60ffu0oytVdJTu5s3+BXMCPaosPDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 October 2014 03:32, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 10/07/2014 08:21 AM, Tomeu Vizoso wrote:
>>
>> Hello,
>>
>> this second version of the series adds several cleanups that were
>> suggested by
>> Stephen Boyd and contains several improvements to the seventh patch (clk:
>> Make
>> clk API return per-user struct clk instances) that were suggested by him
>> during
>> the review of v1.
>>
>> The first six patches are just cleanups that should be desirable on their
>> own,
>> and that should make easier to review the actual per-user clock patch.
>>
>> The seventh patch actually moves the per-clock data that was stored in
>> struct
>> clk to a new struct clk_core and adds references to it from both struct
>> clk and
>> struct clk_hw. struct clk is now ready to contain information that is
>> specific
>> to a given clk consumer.
>>
>> The eighth patch adds API for setting floor and ceiling constraints and
>> stores
>> that information on the per-user struct clk, which is iterable from struct
>> clk_core.
>>
>>
>
> As said in the patches, can you please indicate which baseline this is on?

Sure, this was based on v3.17. Also available at:

http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=per-user-clk-constraints-v2

> Also can you rebase onto clk-next if you send again before that is merged
> into 3.18-rc1? There are some changes in the debugfs part that will
> conflict. I'll review the more complicated parts in detail soon.

Ack.

Thanks,

Tomeu
