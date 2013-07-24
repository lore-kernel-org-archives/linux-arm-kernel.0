From: amit.daniel@samsung.com (amit daniel kachhap)
Date: Wed, 24 Jul 2013 15:25:48 +0530
Subject: [PATCH V2 2/2] ARM: EXYNOS: cpuidle: Allow C1 state only in
 supported SOC's.
In-Reply-To: <0e7d01ce8840$82f79070$88e6b150$@org>
References: <1371036526-16589-1-git-send-email-amit.daniel@samsung.com>
 <1371036526-16589-3-git-send-email-amit.daniel@samsung.com>
 <0e2301ce882c$d39021a0$7ab064e0$@org>
 <CADGdYn5uY7A9OB=xGi_oKS3DX6+wRhbKBnTfxjkFY5OtUX3hXg@mail.gmail.com>
 <0e7d01ce8840$82f79070$88e6b150$@org>
Message-ID: <CADGdYn7yOvwr_v5bj9G+iXr_kkqFGXhYPdmcasTPmqh=ROcvnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 1:06 PM, Kukjin Kim <kgene@kernel.org> wrote:
> amit daniel kachhap wrote:
>
> [...]
>
>> >>               /* Support IDLE only */
>> >> -             if (cpu_id != 0)
>> >> +             if (!(soc_is_exynos4210() || soc_is_exynos4212() ||
>> >> +                     soc_is_exynos4412() || soc_is_exynos5250()) ||
>> >> +                     cpu_id != 0)
>> >
>> > How about exynos5420?
>> >
>> > So...
>> >
>> > +               if (soc_is_exynos5440() || cpu_id !=0) ?
>> This is fine.
>>
> So, you will re-send?
Just submitted the patch with this change.

Thanks,
Amit
>
> - Kukjin
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
