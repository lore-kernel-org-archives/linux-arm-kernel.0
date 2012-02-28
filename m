From: rob.lee@linaro.org (Rob Lee)
Date: Tue, 28 Feb 2012 14:49:53 -0600
Subject: [PATCH v5 1/9] cpuidle: Add commonly used functionality for
 consolidation
In-Reply-To: <4F4CF9BE.1000203@gmail.com>
References: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
 <1330318063-25460-2-git-send-email-rob.lee@linaro.org>
 <CAJOA=zOmUTqXdMDcY6Bbs51SsRmTJMMu9xtbPxsyq4oNgSdNjg@mail.gmail.com>
 <CAMXH7KEBggsYEq9irMoEG-fZEjgEFACFhZZ+-JQj0uvwpGsZHA@mail.gmail.com>
 <4F4CF9BE.1000203@gmail.com>
Message-ID: <CAMXH7KEjHRGa-sOYFZhcg8u3bO_rD02JyGbkFoH=TQoZk+vc-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> Any reason that this code is in the header? ?Why not in cpuidle.c?
>>>
>>
>> Not a strong reason. ?I thought making it an inline would introduce
>> slightly less new execution when adding this code (realizing that
>> there are function calls immediately after, so the only benefit is the
>> reduce popping and pushing). ?But it does require an extra copy of
>> this code for any platform driver that does not enable
>> en_core_tk_irqen and instead makes calls to it directly (like omap3).
>> For this case, I don't think the inline implementation should add
>> extra code from what exists today as it should simply replace the
>> existing platform time keeping calls to a standard one defined by the
>> core cpuidle.
>>
> But you will have multiple copies of the inlined code if platforms do
> use it. Or is it used only by the core cpuidle code? In that case, gcc
> can automatically inline static functions.

Used by some platforms as well.

>
> It seems a bit long to inline and this isn't performance critical (at
> least for the enter side).

Ok.  Unless there are further comments supporting the inline method,
I'll switch to non-inline for next version.  Thanks Mike and Rob for
the feedback.

>
> Rob
>
>> I don't have a strong preference with using the inline so if you or
>> others can give your opinion on which method to use and why, I'd be
>> glad to read it.
>>
>>> Regards,
>>> Mike
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
