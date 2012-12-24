From: prasannapadubidri@gmail.com (Prasanna Kumar)
Date: Mon, 24 Dec 2012 11:12:30 +0530
Subject: [PATCH v2 3/3] ARM: EXYNOS5: save CLK_TOP_SRC3 register before
 powergating
In-Reply-To: <CAPmaG0t-PDDzPQknjfA8dMP4eCsm=1xup2k7MC=M2uTeWBnVNQ@mail.gmail.com>
References: <CAPmaG0uqkRcoUBR8Gjv_+BSJ3hwxUCz0G-YKNQX=qvx83i6QOQ@mail.gmail.com>
 <1356006378-17441-4-git-send-email-prasanna.ps@samsung.com>
 <21192551.mmsSZImfn7@flatron>
 <CAGZ6kuOmd_0o71ZZa_p52NR2Fn-vgA+WOWZpx+DUwHZcHTC41g@mail.gmail.com>
 <CAPmaG0t-PDDzPQknjfA8dMP4eCsm=1xup2k7MC=M2uTeWBnVNQ@mail.gmail.com>
Message-ID: <CAPmaG0sgFHaS3V8MNd5i6H1PDO-W9_64mthZEgrefBrqgdtruw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Choi,

On Mon, Dec 24, 2012 at 9:56 AM, Prasanna Kumar
<prasannapadubidri@gmail.com> wrote:
> Hi Choi,
>
> The method "Save/restore clock source register - CLK_SRC_TOP3" was
> suggested as well as preferred by our hardware team.
>
> Would it be possible to give more information on this  alternate method ?
>
   I just wanted to be more clear on the last sentence of my previous email.
   Here alternate method means, the method you have used to fix the issue.
   Kindly share information on that.
   --
Thanks

>
> On Fri, Dec 21, 2012 at 7:07 AM, jonghwan Choi <jhbird.choi@gmail.com> wrote:
>> Hi~
>>
>> This code should be changed.
>>
>> I insert  this code (save/restore clock source register - CLK_SRC_TOP3)
>> temporary.
>>
>> But we removed this code. And we use another  method to fix it.
>>
>> I think this is not right way.
>>
>> Thanks.
>>
>>
>>
>> On Fri, Dec 21, 2012 at 6:06 AM, <tomasz.figa@gmail.com> wrote:
>>>
>>> Hi Prasanna,
>>>
>>> On Thursday 20 of December 2012 17:56:18 Prasanna Kumar wrote:
>>> > This patch adds a software workaround to the hardware
>>> > problem found in exynos5 while powergating.
>>> >
>>> > It is observed that CLK_TOP_SRC3 register gets modified if
>>> > the G-Scaler/MFC devices are power gated. The clock for G-Scaler gets
>>> > set to XXTI which results in the device running very slow .
>>> > A big drop in performance is noticed whilerunning the video.
>>> > This issue also occurs while powergating MFC.
>>> >
>>> > The value of clock source register is restored once the powergating
>>> > operation is completed.
>>>
>>> Is the problem really related to power gating at all? From what you
>>> described in comment in the code, it seems like it's a problem with
>>> suspend/resume, not power gating, so it should be rather saved on suspend
>>> and restored on resume. Please recheck clock save/restore part of power
>>> management code.
>>>
>>> Altering clock configuration registers from power domain code looks really
>>> ugly...
>>>
>>> Best regards,
>>> Tomasz Figa
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>>> linux-samsung-soc" in
>>> the body of a message to majordomo at vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
>
>
> --
> Thanks
> Prasanna Kumar
