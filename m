From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Fri, 11 Feb 2011 15:27:16 +0200
Subject: [PATCH] ARM: SAMSUNG: Removing dependency on CONFIG_PM_DEBUG for
	clock debugging
In-Reply-To: <AANLkTinPP5Qi5KbQSwPbQoBVdNdkOV-mDMiTkJvzrcS8@mail.gmail.com>
References: <1297530374-32635-1-git-send-email-amit.kachhap@linaro.org>
	<AANLkTinjhPP9NxLsOMovETAZLzFO70zmVWtPQ+E4PZj9@mail.gmail.com>
	<AANLkTinPP5Qi5KbQSwPbQoBVdNdkOV-mDMiTkJvzrcS8@mail.gmail.com>
Message-ID: <AANLkTikTgaOP0OOpESZc-pBLsFn93OyfnffJs7iX4+5n@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 11:22 AM, Amit Kachhap <amit.kachhap@linaro.org> wrote:
> yes this is a temporary patch untill all the PM
> components(sleep/resume) are mainlined.
> The exact compilation error is,
>
> ?CC ? ? ?arch/arm/plat-samsung/pm.o
> arch/arm/plat-samsung/pm.c:32: fatal error: mach/pm-core.h: No such
> file or directory
>
> compilation terminated.
> make[1]: *** [arch/arm/plat-samsung/pm.o] Error 1

Your patch is just masking the real problem in that case. Do you
really need to include mach/pm-core.h in plat-samsung/pm.c?

So the real problem seems to be that the platform hasn't been
test-compiled with CONFIG_PM enabled perhaps?

/Amit

> Thanks,
> Amit Daniel
>
>
> On 11 February 2011 02:57, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>>
>> On Sat, Feb 12, 2011 at 7:06 PM, Amit Daniel Kachhap
>> <amit.kachhap@linaro.org> wrote:
>> > Enabling the macro CONFIG_PM_DEBUG is causing compilation error as all PM components
>> > are included which is not in mainline for samsung V310 platform, therefore, this patch
>> > removes the dependency on macro CONFIG_PM_DEBUG for clock debugging through debugfs
>> > interface.
>>
>> What is the exact error? Might be helpful to have it in the patch description.
>>
>> Presumably, this is a temporary patch until PM components
>> (suspend/resume hooks?) are mainlined and then we can put all this
>> back under PM_DEBUG? In that case, it might be a good idea to mark it
>> as such.
>>
>> Regards,
>> Amit
