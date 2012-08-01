From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Wed, 1 Aug 2012 08:50:15 +0530
Subject: [PATCH V2 5/5] arm: samsung: delete frame buffer header files
 from platform
In-Reply-To: <02ee01cd6f89$f218b2c0$d64a1840$%kim@samsung.com>
References: <1343737385-23337-1-git-send-email-l.krishna@samsung.com>
 <1343737385-23337-6-git-send-email-l.krishna@samsung.com>
 <02ee01cd6f89$f218b2c0$d64a1840$%kim@samsung.com>
Message-ID: <CAL1wa8cShB7zDj-CPvfEncX+Up7enKM9MJOt-488dThj_tXbMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kgene,

On Wed, Aug 1, 2012 at 7:34 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Leela Krishna Amudala wrote:
>>
>> The FIMD register headers are moved to include/video/
>> hence, deleting these files from platform side
>>
>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>> ---
>>  arch/arm/plat-samsung/include/plat/regs-fb-v4.h |  159 ---------
>>  arch/arm/plat-samsung/include/plat/regs-fb.h    |  403
> -------------------
>> ----
>>  2 files changed, 0 insertions(+), 562 deletions(-)
>>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb-v4.h
>>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb.h
>>
> No. This should be squashed into first patch on this series. See below.
>
>  arch/arm/plat-samsung/include/plat/regs-fb-v4.h    |  159
> --------------------
>  .../plat/regs-fb.h => include/video/samsung_fimd.h |  145
> ++++++++++++++++--
>  2 files changed, 134 insertions(+), 170 deletions(-)
>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb-v4.h
>  rename arch/arm/plat-samsung/include/plat/regs-fb.h =>
> include/video/samsung_fimd.h (74%)
>

If I squash it with the first patch and if somebody set that as a head
commit, it will break the build. Hence, splitted it up from the first
patch.

Thank you Sylwester for suggesting this split up change.

Regards,
Leela Krishna

> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
