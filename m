From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 20 Jan 2011 09:42:12 +0000
Subject: [PATCH v4] ARM: Thumb-2: Symbol manipulation macros for function
	body copying
In-Reply-To: <87bp3cr0ib.fsf@ti.com>
References: <1295039877-7976-1-git-send-email-dave.martin@linaro.org>
	<87bp3cr0ib.fsf@ti.com>
Message-ID: <AANLkTinPV+v4+T8jPHiVA7=D7tNkoeDrWLQBRhDX5bmV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 10:29 PM, Kevin Hilman <khilman@ti.com> wrote:
> Dave Martin <dave.martin@linaro.org> writes:
>
>> In low-level board support code, there is sometimes a need to
>> copy a function body to another location at run-time.
>>
>> A straightforward call to memcpy doesn't work in Thumb-2,
>> because bit 0 of external Thumb function symbols is set to 1,
>> indicating that the function is Thumb. ?Without corrective
>> measures, this will cause an off-by-one copy, and the copy
>> may be called using the wrong instruction set.
>>
>> This patch adds an fncpy() macro to help with such copies.
>>
>> Particular care is needed, because C doesn't guarantee any
>> defined behaviour when casting a function pointer to any other
>> type. ?This has been observed to lead to strange optimisation
>> side-effects when doing the arithmetic which is required in
>> order to copy/move function bodies correctly in Thumb-2.
>>
>> Thanks to Russell King and Nicolas Pitre for their input
>> on this patch.
>>
>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>> Tested-by: Jean Pihet <j-pihet@ti.com>
>
> Tested-by: Kevin Hilman <khilman@ti.com>
>
> along with Jean's OMAP patch on:
>
> OMAP2420/n810: including basic suspend/resume test.
>
> OMAP16xx/OSK: boot test only.
>
> Kevin
>

Thanks
---Dave
