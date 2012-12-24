From: prasannapadubidri@gmail.com (Prasanna Kumar)
Date: Mon, 24 Dec 2012 09:48:22 +0530
Subject: [PATCH v2 3/3] ARM: EXYNOS5: save CLK_TOP_SRC3 register before
 powergating
In-Reply-To: <21192551.mmsSZImfn7@flatron>
References: <CAPmaG0uqkRcoUBR8Gjv_+BSJ3hwxUCz0G-YKNQX=qvx83i6QOQ@mail.gmail.com>
 <1356006378-17441-4-git-send-email-prasanna.ps@samsung.com>
 <21192551.mmsSZImfn7@flatron>
Message-ID: <CAPmaG0v_d1_oG6F0hGdti_iPwR05=B5kBTMOw2boYs0Bp31jWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi tomasz,

On Fri, Dec 21, 2012 at 2:36 AM,  <tomasz.figa@gmail.com> wrote:
> Hi Prasanna,
>
> On Thursday 20 of December 2012 17:56:18 Prasanna Kumar wrote:
>> This patch adds a software workaround to the hardware
>> problem found in exynos5 while powergating.
>>
>> It is observed that CLK_TOP_SRC3 register gets modified if
>> the G-Scaler/MFC devices are power gated. The clock for G-Scaler gets
>> set to XXTI which results in the device running very slow .
>> A big drop in performance is noticed whilerunning the video.
>> This issue also occurs while powergating MFC.
>>
>> The value of clock source register is restored once the powergating
>> operation is completed.
>
> Is the problem really related to power gating at all? From what you
> described in comment in the code, it seems like it's a problem with
> suspend/resume, not power gating, so it should be rather saved on suspend
> and restored on resume. Please recheck clock save/restore part of power
> management code.

The problem is only seen in following sequence.
1. Suspend and then Resume the system
2. Power Gating ( On-> Off ) of the associated power domain ( Gscaler , MFC ...)

I rechecked clock save/restore part of power
management code.The register is already being saved clock save/restore
part of power
management code. ( exynos5_clock_save. in clock-exynos5.c).

I hope you have understood the situation here.

> Best regards,
> Tomasz Figa
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Thanks
Prasanna Kumar
