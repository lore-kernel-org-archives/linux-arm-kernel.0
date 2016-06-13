From: inki.dae@samsung.com (Inki Dae)
Date: Mon, 13 Jun 2016 10:38:17 +0900
Subject: [PATCH] drm/exynos: don't use HW trigger for Exynos5420/5422/5800
In-Reply-To: <CABxcv=nuw7ZUF0bDC1PZfP0WVQhRY3HSoO5LdwT8_FvNi9N+aQ@mail.gmail.com>
References: <CGME20160602142058epcas1p4f26bc6ab2acd0012962f90bb2c6c4141@epcas1p4.samsung.com>
 <1464877210-27207-1-git-send-email-javier@osg.samsung.com>
 <5758A58D.7050106@samsung.com>
 <6e24059d-16f3-210a-8dd2-f8dcb89213a1@osg.samsung.com>
 <5759EF32.5040302@samsung.com>
 <CABxcv=nuw7ZUF0bDC1PZfP0WVQhRY3HSoO5LdwT8_FvNi9N+aQ@mail.gmail.com>
Message-ID: <575E0E89.40400@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



2016? 06? 10? 09:24? Javier Martinez Canillas ?(?) ? ?:
> Hello Inki,
> 
> On Thu, Jun 9, 2016 at 6:35 PM, Inki Dae <inki.dae@samsung.com> wrote:
> 
> [snip]
> 
>>> I know that removing .trg_type is enough but I also removed those lines
>>> because the fields are not used if .trg_type != I80_HW_TRG. So there is
>>> no point to leave a set for unused fields.
>>>
>>> We can latter add those one HW trigger support is fixed for Exynos5420.
>>>
>>
>> As of now, I can merge it but I think it would be not reasonable solution because potential problem still exists even we use SW trigger mode in default - ie., in case of using HW trigger mode at bootloader, same problem would happen as long as we don't support PSR mode support.
>>
> 
> Yes, I understand that the problem will show again if the bootloader
> uses HW trigger mode and that we need proper Panel Self Refresh
> support but I think that's a separate issue. That's why I said that
> those can be addressed for v4.8 but revert to SW trigger for v4.7 as a
> short term fix for the regression.
> 
> In other words, enabling HW trigger mode breaks the display for the
> Exynos5420 and Exynos5800 Peach Pi Chromebooks with the shipped
> bootloaders (which are probably the most popular Exynos5 devices with
> display and mainline support so is likely to affect users).

I thought to add PSR support somehow but put me other things to trouble.
Anyway, we could support it later so picked it up.

Thanks,
Inki Dae

> 
> Best regards,
> Javier
> 
> 
> 
