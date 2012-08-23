From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Thu, 23 Aug 2012 12:56:59 +0900
Subject: [PATCH 1/4] ARM: export read_current_timer
In-Reply-To: <20120822174945.GS9093@mudshark.cambridge.arm.com>
References: <1345645780-2749-1-git-send-email-arnd@arndb.de>
 <1345645780-2749-2-git-send-email-arnd@arndb.de>
 <503513A2.1030002@codeaurora.org>
 <20120822174945.GS9093@mudshark.cambridge.arm.com>
Message-ID: <5035AA0B.7090003@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/23/2012 2:49 AM, Will Deacon wrote:
> On Wed, Aug 22, 2012 at 06:15:14PM +0100, Stephen Boyd wrote:
>> On 08/22/12 07:29, Arnd Bergmann wrote:
>>> read_current_timer is used in the get_cycles() function when
>>> ARM_ARCH_TIMER is set, and that function can be inlined into
>>> driver modules, so we should export the function to avoid
>>> errors like
>>>
>>> ERROR: "read_current_timer" [drivers/video/udlfb.ko] undefined!
>>> ERROR: "read_current_timer" [crypto/tcrypt.ko] undefined!
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
>>
>> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
>>
>> I ran into this last week but forgot to send the patch. Thanks.
> 
> Looks good to me, thanks Arnd:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

I haven't hit with this so far with our configs though, but why not?

Acked-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
