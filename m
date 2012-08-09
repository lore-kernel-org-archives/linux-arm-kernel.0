From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 9 Aug 2012 11:21:01 +0530
Subject: [PATCH] ARM: OMAP4: sleep: Save the complete used register stack
 frame
In-Reply-To: <87d331wbiv.fsf@ti.com>
References: <1342183715-13734-1-git-send-email-santosh.shilimkar@ti.com>
 <87d331wbiv.fsf@ti.com>
Message-ID: <CAMQu2gzzNjd7-5MOB27k-wCq+bKfzPmR1RebXYzzBTxsQvYqzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2012 at 10:45 PM, Kevin Hilman <khilman@ti.com> wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> OMAP4 sleep entry code even though itself don't use many CPU registers
>> makes call to the v7_flush_dcache_all() which uses them. Since
>> v7_flush_dcache_all() doesn't make use of stack, the caller must take
>> care of the stack frame. Otherwise it will lead to corrupted stack frame.
>>
>> Fix it by saving used registers.
>>
>> Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>
> Please add a brief comment in the code as well explaining why the
> additional registers are saved/restored.
>
Ok.
> After that, I'll add to my PM fixes queue for v3.6-rc.
>
Thanks.

Regards
Santosh
