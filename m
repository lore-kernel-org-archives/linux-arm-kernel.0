From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 8 Feb 2016 15:30:47 +0100
Subject: [PATCH v5sub2 0/8] arm64: implement virtual KASLR
In-Reply-To: <20160208121430.GL6076@e104818-lin.cambridge.arm.com>
References: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu-AhLcatkDsQVeoFGJ+pTEwaW1Hy9M-fY1-VWvRc_E47w@mail.gmail.com>
 <20160205173248.GJ6076@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_v1sXM7sivz+Uu86ZG3=Th7wqqh7M1N8wF7Ess4NdTZQ@mail.gmail.com>
 <CAGXu5j+JpwRrVy1b_h+LJ4sCzsT7BV9RdcD0CvR-4aVJQhCpvg@mail.gmail.com>
 <20160208121430.GL6076@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu-=RLS8Zgn_evmoUUSHqSVfaw9_hjVMgfg1FZGRDGFVag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 February 2016 at 13:14, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Feb 05, 2016 at 12:42:30PM -0800, Kees Cook wrote:
>> On Fri, Feb 5, 2016 at 9:38 AM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>> > On 5 February 2016 at 18:32, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> >> I'm still trying to get my head around how we merge those. Since I
>> >> assume akpm will push them during the merging window, part of your code
>> >> cannot be tested before.
>> >
>> > Actually, my original idea was for akpm to take them as a late merge
>> > after rebasing to -rc1, since they touch a variety of architectures,
>> > but I am not sure if that came across.
>> >
>> > You could always take the series through your tree instead, I guess?
>>
>> Traditionally akpm will de-duplicate patches he's carrying that appear
>> in another tree. I think it should be okay to carry them in both
>> places. (Though I'm CCing akpm just to see if I'm talking crazy.)
>
> For now, I'll merge this series in the arm64 tree and push it to next:
>
> http://lkml.kernel.org/r/1452007180-27411-1-git-send-email-ard.biesheuvel at linaro.org
>
> If there are any objections, I can drop the patches and do the
> BUILDTIME_EXTABLE_SORT disabling trick until they end up in mainline.
>

Latest version is here:
http://lkml.kernel.org/r/1453892123-17973-1-git-send-email-ard.biesheuvel at linaro.org
(only difference is an ack from that Alpha maintainter/supporter to
patches #1 and #2)

However, the arm64 patch (#6) now conflicts with futex.h in -rc3 after
the PAN fix, not sure how to best address that ...

-- 
Ard.
