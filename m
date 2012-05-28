From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Mon, 28 May 2012 15:22:50 +0530
Subject: [PATCHv9 00/10] I2C fixes
In-Reply-To: <87r4u7j4dr.fsf@ti.com>
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
 <87r4u7j4dr.fsf@ti.com>
Message-ID: <4FC34AF2.9000302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,


On Saturday 26 May 2012 03:43 AM, Kevin Hilman wrote:
> Shubhrajyoti D <shubhrajyoti@ti.com> writes:
>
>> The patch series does the following
>>
>> - Warn fixes if CONFIG_PM_RUNTIME is not selected.
>> - In case of i2c remove register access was done without any
>>  get_sync fix the same.
>> - Folds a patch from Tasslehoff to prevent any merge conflicts.
>> - Prevents the XDUF flag to be set if the underflow condition is not met.
>> - As per discussion in [1] .Adds a patch to rename the 1p153 errata and
>>  use the unique id instead as the section number in the recent errata
>>  docs has changed.
>>
>> v9:
>> Fix the comments from Wolfram Sang
>>
>> [1] http://www.spinics.net/lists/linux-i2c/msg07607.html
>>
>> Tested on omap4sdp and omap3sdp.
> Can you also describe how it was tested?  
I did basic functionality  tests using i2c-tools.
>
> With the runtime PM changes, does it still hit full-chip retention in
> idle and suspend after these changes?
Will check.
>
> I had a few minor comments on this version,
Will fixup and resend.
>  otherwise feel free add
>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
Thanks for your review.
>
> That being said, before this is merged, I woudl like to see some more
> non-author Tested-bys.  We've been having lots of regressions of late
> from OMAP drivers that are not being sufficiently tested before
> merging.  We need to ensure proper testing before merge.
>
> Other testers should also report what platforms they tested on, and how
> it was tested.
>
> Thanks,
>
> Kevin
