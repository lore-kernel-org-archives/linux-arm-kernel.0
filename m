From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 5 Mar 2014 21:00:22 +0530
Subject: [PATCH 1/1] ARM: Exynos: Add generic compatible string
In-Reply-To: <531714C4.2040200@gmail.com>
References: <1392809645-631-1-git-send-email-sachin.kamat@linaro.org>
 <CAK9yfHxXTbNmgTYqFH1Mm-X_sN2GpfLPp0MKixU=g2bKxz8e=g@mail.gmail.com>
 <CAOesGMiZXKRbrbmvKs4pF7HiXM1hsGjzbFUQmJ-n5-nar5uMBw@mail.gmail.com>
 <201402251242.30654.arnd@arndb.de>
 <CAK9yfHxg8kwL2zFy7ErW4kR1_5BerxqaLyaJx3Jko8wLRGdCkw@mail.gmail.com>
 <531714C4.2040200@gmail.com>
Message-ID: <CAK9yfHyDbx8DcdFvoAQZuo9RWLTZmXZPj8gSo8B4z=R0c=Lf4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 March 2014 17:42, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On 05.03.2014 09:25, Sachin Kamat wrote:
>>
>> On 25 February 2014 17:12, Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>> On Tuesday 25 February 2014, Olof Johansson wrote:
>>>>
>>>> I disagree. I don't know what Samsung has in mind, but the revision of
>>>> the CPU doesn't have all that much to do with the rest of the SoC.
>>>> It's quite likely that some vendors (maybe not Samsung, but the same
>>>> concept applies) will ship 64-bit SoCs that are very similar to their
>>>> preceding 32-bit ones, same IP, similar busses, etc. I'm pretty sure
>>>> at least some vendors will do very close to that.
>>>
>>>
>>> Right.
>>>
>>>> So, if EXYNOS4 and EXYNOS5 can share a compatible value when they use
>>>> different CPUs, then there's no reason that whatever future 64-bit
>>>> ones can also share it.
>>>
>>>
>>> How about putting both 'samsung,exynos' and 'samsung,exynos4' in DT then
>>> and having the platform code match exynos4 and exynos5 but not exynos?
>>>
>>> That way, I think we are consistent and future-proof. Any code that needs
>>> to know if it's running on some exynos version can just check for the
>>> 'samsung,exynos' compatible value and that will work on both arm32 and
>>> arm64. Also, if we ever decide we want to run a 32-bit kernel on a 64-bit
>>> exynos, we can just add 'samsung,exynos6' (or whatever number that will
>>> be) to the list.
>>>
>>> My usual disclaimer for this: You should never ever consider actually
>>> running a 32-bit kernel on a 64-bit CPU, but at the same time there
>>> shouldn't be any reason why it won't work either, given that we require
>>> arm64 based systems to have all SoC specific code in drivers and we
>>> can use the same drivers on arm32.
>>
>>
>> Kukjin, Tomasz,
>>
>> What is your opinion about Arnd's suggestion?
>>
>
> I would still prefer introducing a generic string for 32-bit Exynos SoCs,
> but I don't think it really matters a lot. I guess we can stick to just
> exynos4 and exynos5 compatible strings then, as long as we can merge the
> "board"-files and common.c together, since the code is pretty much
> SoC-independent now.

OK. Just wanted a confirmation before sending out the patches.
Thanks.

-- 
With warm regards,
Sachin
