From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 May 2016 14:43:16 +0200
Subject: [PATCH] ARM: dts: exynos: Only Odroid XU3-family boards use DTSI
 with CPU thermal nodes
In-Reply-To: <CANAwSgTy6p9AVmmOWATpSO1JqVbwE0v+y_y-RLd+32RnNJTA+Q@mail.gmail.com>
References: <1462774789-15360-1-git-send-email-k.kozlowski@samsung.com>
 <CANAwSgT9SY3kj8+beMpc1xGoC=rMBSya+2v2dyZQp6ykH+V0=g@mail.gmail.com>
 <573198BE.6020900@samsung.com>
 <CANAwSgTy6p9AVmmOWATpSO1JqVbwE0v+y_y-RLd+32RnNJTA+Q@mail.gmail.com>
Message-ID: <5731D764.8070007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2016 11:29 AM, Anand Moon wrote:
>>
>> I am sorry but I do not understand.
>> 1. Are you saying that my patch causes the issue?
>> 2. Are you saying that I should not send some patches because of
>> conflicting work? (that would be peculiar...)
>> 3. Are you saying that I should not apply this patch to me tree because
>> of conflicting work?
>> 4. Other?
>>
>> Best regards.
>> Krzysztof
>>
>>
> 
> Sorry for the confusion it's not about you patch.
> The feature is not working correctly as per my testing with the
> original source code.
> It need to be more tuned or some other approach to the issue need to found.

Known issue. You don't have cpufreq cooling enabled. I sent patches for
that and they are in the mainline. However cpufreq cooling requires
cpufreq which cannot work with BL_SWITCHER and on Exynos542x on
exynos_defconfig BL_SWITCHER is enabled.

Just disable the BL_SWITCHER.

Best regards,
Krzysztof
