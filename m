From: shubhrajyoti.datta@gmail.com (Shubhrajyoti Datta)
Date: Sat, 21 Nov 2015 19:00:07 +0530
Subject: [PATCH v2] i2c: cadence: Move to sensible power management
In-Reply-To: <CAKfKVtHbKrYK-JkQRWO3hEyOkGEW8q9zc6r90PNP8uEm3VXc4Q@mail.gmail.com>
References: <1446017200-30373-1-git-send-email-shubhraj@xilinx.com>
 <20151028161810.GB6436@xsjsorenbubuntu>
 <CAKfKVtHbKrYK-JkQRWO3hEyOkGEW8q9zc6r90PNP8uEm3VXc4Q@mail.gmail.com>
Message-ID: <CAKfKVtHHKcs1UAM4pb4Qbtn5TEOboZf1SrL4qFuFZYSCUundHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 8:27 PM, Shubhrajyoti Datta
<shubhrajyoti.datta@gmail.com> wrote:
> On Wed, Oct 28, 2015 at 9:48 PM, S?ren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
>> Hi Shubhrajyoti,
>>
>>
>> On Wed, 2015-10-28 at 12:56PM +0530, Shubhrajyoti Datta wrote:
>>> Currently the clocks are enabled at probe and disabled at remove.
>>> Which keeps the clocks enabled even if no transaction is going on.
>>> This patch enables the clocks at the start of transfer and disables
>>> after it.
>>>
>>> Also adapts to runtime pm.
>>> Remove xi2c->suspended and use pm runtime status instead.
>>>
>>> converts dev pm to const to silence a checkpatch warning.
>>>
>>> Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
>>
>> To me, this looks all good. Just one small concern below.
>
> Thanks for the review.
Soren ,
Do are you ok with the change or do you want me to resend without the
suspended flag change.

<>
>>
>> There might have been a reason to store this flag here. Did you test
>> this with lockdep and CONFIG_DEBUG_ATOMIC_SLEEP? Just to make sure that
>> nothing that can sleep is called from atomic context.
> Done now.
>
>
> Essentially this is a flag is set in suspend routine. and checked in
> the isr I use
> pm_runtime_suspended(id->dev) instead.
>
>>
>>         S?ren
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
