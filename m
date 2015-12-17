From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 17 Dec 2015 22:19:31 +0100
Subject: [PATCH RFC 01/27] PM / Domains: core changes for multiple states
In-Reply-To: <CAKXjFTOMwMBq7Md6BFLuGnq4yQTZOyv4QVA6Cw7MWrkH0PvYDg@mail.gmail.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-2-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFoBkKdBpuA6_EMtQNc-n0HxVAFpULrxgpnU5eXtcuS6og@mail.gmail.com>
 <CAKXjFTOMwMBq7Md6BFLuGnq4yQTZOyv4QVA6Cw7MWrkH0PvYDg@mail.gmail.com>
Message-ID: <CAPDyKFovwXNnr4RPDww_wp_4+mOjN7ZL1zfc3i=G4EbktzsJOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>>> +static int genpd_alloc_states_data(struct generic_pm_domain *genpd,
>>
>> In this patch I would rather just add *one* new "alloc" function and
>> name it like below.
>>
>> static int genpd_alloc_default_state(struct generic_pm_domain *genpd)
>>
>> I assume the name I suggest for it, indicates what it needs to do and
>> *not* needs to do.
>
> Hi Ulf,
>
> Thanks for your thorough review!
> i will implement your suggestions for the next spin,

Great, thanks!

>
> However I have a doubt about this comment, do you mean that i should get rid of
> genpd_alloc_states_data completly? i had a static number of states before

Yes, in this patch - but we still want to alloc the data on the heap.

Just alloc a state struct with size of one array.

> but that was droped because o wasted memory if no states were needed.

There will always be at least *one* state, so we shouldn't waste any
memory following my suggestion above.

>
> if you just meant that it should be added in a separate patch, since i
> will be sqashing

I think you need to go through review comments for each patch
separately. In the end that might very well mean that you should
completely drop some patches, rework some and even create some some
new.

> this patch with "PM / Domains: make governor select deepest state"   can
> i keep it here? maybe it should  go with the dt parsing patch from Marc?

I don't think so.

Try to keep each logical change in a separate patch. That makes it
easier to review and thus also to accept patches.

[...]

Kind regards
Uffe
