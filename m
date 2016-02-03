From: fu.wei@linaro.org (Fu Wei)
Date: Thu, 4 Feb 2016 02:18:38 +0800
Subject: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
In-Reply-To: <56B2423B.1020109@codeaurora.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <56B23883.7000501@codeaurora.org>
 <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
 <56B23E99.1030604@codeaurora.org>
 <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
 <56B2423B.1020109@codeaurora.org>
Message-ID: <CADyBb7uULCn97ea19zH8dB4QX1QA8=AXL94d6gXgFxXM8haBNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 February 2016 at 02:08, Timur Tabi <timur@codeaurora.org> wrote:
> Fu Wei wrote:
>>
>> Actually I am taking your suggestion to avoid touching WCV in
>> interrupt routine.
>> So even we have pre-timeout support , it is useless for this
>> panic-on-half-timeout feature,
>> because pre-timeout  == timeout / 2 (always).
>>
>> So maybe I misunderstand your suggestion,
>> could you let me know : why we want pre-timeout here?
>
>
> Maybe I'm confused.
>
> For pre-timeout, I think the SBSA watchdog driver should support only
> half-timeout.  That is, the user cannot configure the length of the
> pre-timeout with this driver.  He can only enable it, and it is
> automatically set to 1/2 timeout.

Actually,
the SBSA watchdog driver should support only  half-timeout for panic
the user cannot configure the length of "panic time",  He can only
enable it, and it is automatically set to 1/2 timeout.

we don't need pre-timeout here.

Hope I understand you correctly :-) sorry for your confusion

>
> So when pre-timeout occurs, the interrupt handler calls panic() or whatever
> it's supposed to do.

Actually,
So when 1/2 timeout occurs, the interrupt handler calls panic() or
whatever it's supposed to do.

>
> So "pre-timeout  == timeout / 2 (always)" is exactly what we want.

our patchset is doing this way.



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
