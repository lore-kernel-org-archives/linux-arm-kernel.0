From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 20 Aug 2013 22:01:29 +0200
Subject: [RFC 05/17] ARM: highbank: remove custom .init_time hook
In-Reply-To: <5213BF91.3030300@calxeda.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-6-git-send-email-sebastian.hesselbarth@gmail.com>
 <5213BF91.3030300@calxeda.com>
Message-ID: <5213CB19.6000905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2013 09:12 PM, Rob Herring wrote:
> On 08/19/2013 09:04 PM, Sebastian Hesselbarth wrote:
>> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
>> remove custom .init_time hooks. Highbank clock provider need a reference
>> to system registers, as a workaround current clk driver maps those
>> independent of arch code now.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> ---
>> Notes:
>> - I suggest to consolidate the four single clock providers into a single
>>    provider with one node if possible.
>
> And how do you suggest doing that while maintaining the DT ABI?

Rob,

I am aware of ABI status of the DT bindings and the discussion about
deprecating/cleanup of what went in in the past. Maybe "suggest" is a
little bit too strong and should have been "would be nice to have".

But looking at clk-highbank, all providers depend on the same register.
If you'd introduce e.g. a new "calxeda,core-clocks" that sets up the
four providers and also CLK_OF_DECLARE the same init with one out of
the  four existing compatibles shouldn't that maintain backwards
compatibility?

Anyway, I was just puting the note above to raise some comment on it.
You actually gave a good one to leave it as is.

>> ---
>>   arch/arm/mach-highbank/highbank.c |   23 +++++++----------------
>>   drivers/clk/clk-highbank.c        |   10 +++++++---
>>   2 files changed, 14 insertions(+), 19 deletions(-)
>
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Ok, I keep that in mind until all other issues are resolved.

Thanks,
   Sebastian
