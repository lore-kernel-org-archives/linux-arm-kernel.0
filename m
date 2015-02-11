From: addy.ke@rock-chips.com (Addy)
Date: Wed, 11 Feb 2015 11:03:11 +0800
Subject: [PATCH] mmc: dw_mmc: fix bug that cause mmc_test failture
In-Reply-To: <CAOesGMiWBjhfzWVXah2XO7=JQhriwdVgf0jmm1UjNQjB9PeGMQ@mail.gmail.com>
References: <1422273849-29773-1-git-send-email-addy.ke@rock-chips.com>
 <CAOesGMiWBjhfzWVXah2XO7=JQhriwdVgf0jmm1UjNQjB9PeGMQ@mail.gmail.com>
Message-ID: <54DAC66F.60301@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2015/02?10? 17:34, Olof Johansson wrote:
> Hi Addy,
>
> On Mon, Jan 26, 2015 at 4:04 AM, Addy Ke <addy.ke@rock-chips.com> wrote:
>> The STOP command can terminate a data transfer between a memory card and
>> mmc controller.
>>
>> As show in Synopsys DesignWare Cores Mobile Stroage Host Databook:
>> Data timeout and Data end-bit error will terminate further data transfer
>> by mmc controller. So we should not send abort command to terminate a
>> data transfer again if we got DRTO and EBE interrupt.
>>
>> After this patch, all mmc_test cases can pass on RK3288-Pink2 board.
>>
>> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> The drawback of having so many people on your to: list on a patch is
> that it's unclear who you want to review and merge it. Sometimes less
> is more.
I will remove some unnecessary mail address from list in the following 
patch.
Thank you.
>
> In this case, it seems appropriate to have Ulf do so. Ulf, ping? This
> seems like a reasonable patch for 3.20 given that it fixes undesired
> behavior.
>
>
> -Olof
>
>
>
