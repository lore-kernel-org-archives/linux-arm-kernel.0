From: javierm@redhat.com (Javier Martinez Canillas)
Date: Tue, 12 Dec 2017 08:41:46 +0100
Subject: [RFT PATCH] ARM: dts: exynos: Enable Mixer node for Exynos5800
 Peach Pi machine
In-Reply-To: <3e6e4b15-9f8a-bea1-3c8e-2d85fc4c512d@samsung.com>
References: <CGME20171211224905epcas1p4e6d66369f60c7dae0678efc95d0bdb6e@epcas1p4.samsung.com>
 <20171211224856.29264-1-javierm@redhat.com>
 <3e6e4b15-9f8a-bea1-3c8e-2d85fc4c512d@samsung.com>
Message-ID: <2dcc4a3d-bb9a-8338-8273-c5eae58dce34@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marek,

On 12/12/2017 08:01 AM, Marek Szyprowski wrote:
> Hi
> 
> On 2017-12-11 23:48, Javier Martinez Canillas wrote:
>> Commit 1cb686c08d12 ("ARM: dts: exynos: Add status property to Exynos 542x
>> Mixer nodes") disabled the Mixer node by default in the DTSI and enabled
>> for each Exynos 542x DTS. But unfortunately it missed to enable it for the
>> Exynos5800 Peach Pi machine, since the 5800 is also an 542x SoC variant.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>

Thanks.
 
>> ---
>>
>> I believe this may cause the boot issues reported on Exynos5800 Peach Pi
>> from v4.15-rc3, the mentioned commit made to v4.15-rc1 but it seems that
>> didn't cause any harm until commit ("510353a63796 drm/bridge: analogix
>> dp: Fix runtime PM state in get_modes() callback") fixed the runtime PM
>> management in the DP driver.
> 
> Thanks for analyzing this. Lack of this change was probably responsible for
> Exynos DRM initialization failure ("exynos-drm exynos-drm: failed to bind
> 14530000.hdmi (ops hdmi_component_ops): -1" message and probably further
> error "unbalanced disables for lcd_vdd", which shows that failure path of
> analogix dp and simple panel causes unbalanced regulator disable.
>

Yes, I came to the same conclusion than you in the thread started by
Guillaume. I just couldn't test it.
 
> This patch should go to v4.15-rcX (fixes) if possible.
>

Indeed. I wondered if it also needed a Fixes tag. I didn't include it because
I thought that both the culprit and the fix would be in the same kernel release.

But I'll include it anyways.
 
>> I can't test right now, but I'm posting anyways as a RFT in case others
>> that have access to a Peach Pi can test it.
>>
>> Best regards,
>> Javier
>>
>>   arch/arm/boot/dts/exynos5800-peach-pi.dts | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> index b2b95ff205e8..0029ec27819c 100644
>> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> @@ -664,6 +664,10 @@
>>   	status = "okay";
>>   };
>>   
>> +&mixer {
>> +	status = "okay";
>> +};
>> +
>>   /* eMMC flash */
>>   &mmc_0 {
>>   	status = "okay";
> 
> Best regards
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
