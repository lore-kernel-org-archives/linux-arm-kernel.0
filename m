From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 20 Jan 2014 21:49:16 -0800
Subject: [PATCH] ARM: asm: __und_usr_thumb need byteswap instructions in
 BE case
In-Reply-To: <52DDD3C8.7080306@codeaurora.org>
References: <1389652251-18298-1-git-send-email-victor.kamensky@linaro.org>
 <20140114090518.GA2222@e103592.cambridge.arm.com>
 <52DDD3C8.7080306@codeaurora.org>
Message-ID: <CAA3XUr2RT_LesBHYY6i8teu7UQCjK0ZKarSry=QeddW1HiK+eA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2014 17:56, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 01/14/14 01:05, Dave Martin wrote:
>> On Mon, Jan 13, 2014 at 02:30:51PM -0800, Victor Kamensky wrote:
>>> __und_usr_thumb function deals with thumb2 opcodes. In case of BE
>>> image, it needs to byteswap half word thumb2 encoded instructions
>>> before further processing them.
>>>
>>> Without this fix BE image user-land thread executing first VFP
>>> instruction encoded in thumb2 fails with SIGILL, because kernel
>>> does not recognize instruction and does not enable VFP.
>>>
>>> Reported-by: Corey Melton <comelton@cisco.com>
>>> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>> Good spot.  This looks like the correct fix to me.
>>
>> Acked-by: Dave Martin <Dave.Martin@arm.com>
>>
>
> Can you please send this to the patch tracker? Feel free to add
>
> Tested-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks. It is done on both counts. Patch is submitted as [1].

Thanks,
Victor

[1] http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7946/1

> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
>
