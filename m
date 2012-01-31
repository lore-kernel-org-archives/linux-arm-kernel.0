From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Tue, 31 Jan 2012 14:39:48 +0100
Subject: [PATCH 07/21] OMAP3+: PM: SR/Class3: disable errorgen before
 disable VP
In-Reply-To: <4F27D264.9050203@ru.mvista.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
 <1327504583-13408-8-git-send-email-j-pihet@ti.com>
 <4F213860.9050600@ru.mvista.com>
 <CAORVsuUNM8bpwyjbG2GcwfiUEf7A54ODC4tfhZNinUhQTE3g5w@mail.gmail.com>
 <4F27D264.9050203@ru.mvista.com>
Message-ID: <CAORVsuWrO49aUi7iab=qzxPOjaxkOwFa6bTtdRedK+pX-59t8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei,

On Tue, Jan 31, 2012 at 12:37 PM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Hello.
>
>
> On 31-01-2012 14:06, Jean Pihet wrote:
>
>> ...
>
>
>>>> +int sr_disable_errgen(struct voltagedomain *voltdm)
>>>> +{
>>>> + ? ? ? u32 errconfig_offs, vpboundint_en;
>>>> + ? ? ? u32 vpboundint_st;
>>>> + ? ? ? struct omap_sr *sr = _sr_lookup(voltdm);
>>>> +
>>>> + ? ? ? if (IS_ERR(sr)) {
>>>> + ? ? ? ? ? ? ? pr_warning("%s: omap_sr struct for sr_%s not found\n",
>>>> + ? ? ? ? ? ? ? ? ? ? ? __func__, voltdm->name);
>>>> + ? ? ? ? ? ? ? return -EINVAL;
>>>
>>>
>>>
>>> ? Not PTR_ERR(sr)?
>
>
>> _sr_lookup returns a return code using ERR_PTR so the return value
>> should be checked for errors using IS_ERR. Please note that _sr_lookup
>> checks for NULL parameter internally.
>
>
> ? That's clear. I was asking don't you want to return PTR_ERR(sr) instead of
> -EINVAL.
Oh yes you are correct, that is a good catch. Sorry for my misunderstanding.

I caught the same problem at a few other places and I have a patch
ready for the error handling code. To be submitted asap.

>
> WBR, Sergei

Thanks!
Jean
