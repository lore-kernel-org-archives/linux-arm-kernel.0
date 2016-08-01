From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 1 Aug 2016 17:26:22 +0900
Subject: [Urgent PATCH] arm64: dts: uniphier: fix IRQ trigger type of
 ARMv8 timer
In-Reply-To: <579F05E1.9020300@arm.com>
References: <1470039140-3801-1-git-send-email-yamada.masahiro@socionext.com>
 <579F05E1.9020300@arm.com>
Message-ID: <CAK7LNAQo6Si9q0FQw=3i67yGO1JYuDxHBB=xsLZOj8S-TBG_Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

2016-08-01 17:18 GMT+09:00 Marc Zyngier <marc.zyngier@arm.com>:
> Please keep me cc-ed on this.

Sorry, I automate patch-posting, but scripts/get_maintainer.pl
did not pick you up.  Also, I forgot to cc you explicitly.


> On 01/08/16 09:12, Masahiro Yamada wrote:
>> Since commit 1e2a7d78499e ("irqdomain: Don't set type when mapping
>> an IRQ"), the interrupt type is strictly checked.  Without this
>> patch, this board would not boot any more.
>>
>> Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>> says that the 3rd cell should be either 1 (edge) or 4 (level)
>> depending on the trigger type.  As the CA72 Generic Timer provides
>> active-low interrupts, the value of the 3rd cell should be 4.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>> Arnd, Olof,
>>
>> I guess you are about to send pull-reqs for v4.8 cycle.
>> Could you include this one in them?
>> After IRQ updates for 4.8 were merged, my board would not
>> boot at all.  I consulted experts and looks like my DT
>> was wrong.
>>
>> I could do this after -rc1 is out because it is apparently a
>> bug fix, but in that case the for-next branch in ASOC will be
>> broken for me, which would make bisect-ability difficult for me.
>
> I have a patch that addresses all platforms in one go (there is really
> no point in fixing one at a time for a bug that is so widespread).
>
> I'll repost it later today.
>

That'll be fine.
Thank you!


Arnd, Olof:
Please disregard this one.




-- 
Best Regards
Masahiro Yamada
