From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Fri, 16 May 2014 10:37:58 +0530
Subject: [PATCH v4 0/4] Adds PMU and S2R support for exynos5420
In-Reply-To: <53753021.5050801@gmail.com>
References: <1399982522-27928-1-git-send-email-a.kesavan@samsung.com>
 <53753021.5050801@gmail.com>
Message-ID: <CAM4voan82jypoHTOo9KwsvA7tPzdYYa3QYNHMo4Q2Yvt_cf7gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Fri, May 16, 2014 at 2:52 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Abhilash,
>
> On 13.05.2014 14:01, Abhilash Kesavan wrote:
>> Rebased on
>> 1] Kukjin Kim's tree for-next branch (which has Sachin Kamat's SYSRAM
>> patches merged) with Tomasz Figa's samsung clock tree (samsung-next branch)
>> merged.
>> https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next
>> 2] Pankaj Dubey's v4 PMU patchset
>> https://lkml.org/lkml/2014/5/10/29
>
> I think this patch is not safe to base on yet. I need to find time to
> review the latest version and share my latest view on this with Pankaj,
> as I have a bit different design in mind.
OK, do you think the PMU series might make it this cycle or should I
drop this as a dependency and re-base my patches just on Daniel's
CPUIdle consolidation.

Regards,
Abhilash
>
> In general, I don't like the fact that you end up with using regmap to
> access registers that are used exclusively by PMU driver or for accesses
> happening at late suspend or early resume, where concurrent accesses
> from other drivers simply can't occur.

>
> Best regards,
> Tomasz
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
