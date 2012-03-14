From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 13 Mar 2012 23:43:57 -0700
Subject: [PATCH v3 12/12] ARM: dts: add initial dts file for EXYNOS5250,
 SMDK5250
In-Reply-To: <20120314035655.GB2531@quad.lixom.net>
References: <1331652643-12626-1-git-send-email-kgene.kim@samsung.com>
 <1331652643-12626-13-git-send-email-kgene.kim@samsung.com>
 <20120314035655.GB2531@quad.lixom.net>
Message-ID: <4F603E2D.1050007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/12 20:56, Olof Johansson wrote:
> On Tue, Mar 13, 2012 at 08:30:43AM -0700, Kukjin Kim wrote:
>> This patch adds initial dts file for EXYNOS5250 SoC. This dts
>> file is including the SoC specific devices and properties. And
>> adds the dts file for SMDK5250 board which uses the EXYNOS5250
>> dts file. Its board specific properites will be added later.
>>
>> Cc: Thomas Abraham<thomas.abraham@linaro.org>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5250-smdk5250.dts |   26 ++
>>   arch/arm/boot/dts/exynos5250.dtsi         |  413 +++++++++++++++++++++++++++++
>>   2 files changed, 439 insertions(+), 0 deletions(-)
>>   create mode 100644 arch/arm/boot/dts/exynos5250-smdk5250.dts
>>   create mode 100644 arch/arm/boot/dts/exynos5250.dtsi
>>
>> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
>> new file mode 100644
>> index 0000000..491539a
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts

[...]

>> +	chosen {
>> +		bootargs = "root=/dev/ram0 rw ramdisk=8192 rootfstype=squashfs initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc";
>
> Having these specific bootargs in the include file rarely makes sense, it's
> better to have firmware update from the settings in firmware and just have a very
> simple fallback here.
>
> In particular initrd is quite custom to hardcode like that.
>
Yes, the bootargs is no mandatory in dts file and u-boot bootargs can be 
set. OK, we can simplify it here like following.

bootargs = "root=/dev/ram0 rw ramdisk=8192 console=ttySAC1,115200"

[...]

>> +	watchdog at 101D0000 {
>
> lowercase hex here and elsewhere in these files, please.
>
OK, I see.

> Also, technically no need to specify a unit address (@<foo>) in the device node
> name unless you need it to tell more than one entry apart, but it's become
> customary to always add them on ARM for some reason.
>
OK, just to be consistent in writing device nodes, prefer to add address 
to the names for all device nodes.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
