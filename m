From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 24 Nov 2014 17:35:25 -0800
Subject: [PATCH] ARM: exynos_defconfig: disable CONFIG_EXYNOS5420_MCPM;
 not stable
In-Reply-To: <CAOesGMhvTDN4J6AdUDHKV0Sp4NT6a4QEMUDWOayQqhhD+C4acw@mail.gmail.com>
References: <1414796382-5447-1-git-send-email-khilman@kernel.org>
 <000e01cffb39$5ef0a2d0$1cd1e870$@kernel.org>
 <7hegtaq26c.fsf@deeprootsystems.com>
 <CAMAWPa-mLAFL7v8hHA5R-eBzpMFK-E-xcvjoV8Bn6tTwgP53Uw@mail.gmail.com>
 <CAOesGMhvTDN4J6AdUDHKV0Sp4NT6a4QEMUDWOayQqhhD+C4acw@mail.gmail.com>
Message-ID: <CAMAWPa-sz5jT9izEONVZR2Z4mzuivKaNHSgyR+eP13tWZ84hYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 4:25 PM, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Nov 24, 2014 at 11:51 AM, Kevin Hilman <khilman@kernel.org> wrote:
>> Kukjin,
>>
>> On Mon, Nov 10, 2014 at 11:35 AM, Kevin Hilman <khilman@kernel.org> wrote:
>>> Kukjin Kim <kgene@kernel.org> writes:
>>>
>>>> Kevin Hilman wrote:
>>>>>
>>>>> From: Kevin Hilman <khilman@linaro.org>
>>>>>
>>>>> The option CONFIG_EXYNOS5420_MCPM is causing imprecise external aborts
>>>>> during boot testing, causing various userspace startup failures.
>>>>>
>>>>> Disable until it has gotten more testing.
>>>>>
>>>>> Cc: Kukjin Kim <kgene.kim@samsung.com>,
>>>>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
>>>>> Cc: Sachin Kamat <sachin.kamat@samsung.com>,
>>>>> Cc: Doug Anderson <dianders@chromium.org>,
>>>>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
>>>>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
>>>>> Cc: Tushar Behera <tushar.behera@linaro.org>,
>>>>> Cc: stable at vger.kernel.org # v3.17+
>>>>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>>>>> ---
>>>>> This has been reported by a few people[1], but not investigated or fixed, so it's
>>>>> time to disable this feature until it can be fixed.
>>>>>
>>>> Hi Kevin,
>>>>
>>>> Yeah I agree with your opinion.
>>>>
>>>> But as you can see my tree, I've queued regarding mcpm patches for 3.19 will
>>>> be shown in -next in this weekend.
>>>
>>> Which of the recently queued patches are expected to address the
>>> imprecise abort issue?  I'd be happy to test them out.
>>
>> Exynos5 MCPM is still broken in linux-next and still causing an imprecise abort.
>>
>> What is the status of $SUBJECT patch?
>>
>>>> Anyway let me apply this into -fixes and
>>>> then let's enable after test its functionality in -next in a couple of days.
>>>
>>> Yes, I think this needs to be applied until these aborts are understood
>>> and fixed.
>>
>> Is anyone at Samsung actually looking into these MCPM issues?
>
> Hi Kevin,
>
> What hardware are you having problems with? 5420 or 5422/5800?

Yes.  :)

exynos5420-arndale-octa:
http://storage.armcloud.us/kernel-ci/mainline/v3.18-rc6/arm-exynos_defconfig/boot-exynos5420-arndale-octa.html
exynos5422-odroid-xu3:
http://storage.armcloud.us/kernel-ci/mainline/v3.18-rc6/arm-exynos_defconfig/boot-exynos5422-odroid-xu3.html

My boot tests seem to pass fine because I have such a minimal
userspace, but Tyler Baker reported that with a "real" userspace, he
can't boot to a shell:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/286203.html

Kevin
