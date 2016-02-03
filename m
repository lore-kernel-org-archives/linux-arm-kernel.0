From: fu.wei@linaro.org (Fu Wei)
Date: Thu, 4 Feb 2016 01:49:02 +0800
Subject: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
In-Reply-To: <56B23883.7000501@codeaurora.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <56B23883.7000501@codeaurora.org>
Message-ID: <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timur,

Thanks for your rapid feedback :-)

On 4 February 2016 at 01:27, Timur Tabi <timur@codeaurora.org> wrote:
> fu.wei at linaro.org wrote:
>>
>> +#ifdef CONFIG_ARM_SBSA_WATCHDOG_PANIC
>> +static bool panic_enabled = true;
>
>
> I think this should default to 'false', because IMHO, this seems like an odd

yes, It make sense to make it default to 'false'.

> feature.  I'm not crazy about the fact that there's a Kconfig option for it
> either, but I'm not going to NACK this patch.
>
> I personally would prefer to drop this patch, and just wait for full-blown
> pre-timeout support.  It feels like a debugging feature that doesn't really

sorry, are you saying : using pre-timeout instead of this half timeout?

But even we have pre-timeout support, pre-timeout  == timeout / 2, it
can not be configured without touch timeout.

if you want pre-timeout  != timeout / 2, we have to modify WCV in the
interrupt routine.
 (because of the explicit watchdog refresh  mechanism)

Could you let me know why we need pre-timeout  here ?? :-)

> belong upstream.  But like I said, it's just my opinion, and I won't
> complain if I'm outvoted.

 I think this debugging feature is the  purpose of the two-stage
watchdog, if I understand correctly



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
