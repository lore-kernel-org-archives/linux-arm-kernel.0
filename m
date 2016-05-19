From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 May 2016 10:12:35 -0600
Subject: [PATCH] ARM: tegra: beaver: allow SD card voltage to be changed
In-Reply-To: <573DCE43.70906@nvidia.com>
References: <1456779678-20173-1-git-send-email-dev@lynxeye.de>
 <573DCE43.70906@nvidia.com>
Message-ID: <573DE5F3.2060406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2016 08:31 AM, Jon Hunter wrote:
>
> On 29/02/16 21:01, Lucas Stach wrote:
>> This allows to switch the card signal voltage level to 1.8V,
>> which is needed for any ultra high speed modes to work.
>>
>> Signed-off-by: Lucas Stach <dev@lynxeye.de>
>> ---
>> This needs the SDMMC memcomp pad calibration patches I just
>> sent out to be applied, otherwise the card voltage change will
>> fail with a message in the kernel log and a fall back to
>> high speed operation.
>> ---
>>   arch/arm/boot/dts/tegra30-beaver.dts | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
>> index 1daed40..6b237f2 100644
>> --- a/arch/arm/boot/dts/tegra30-beaver.dts
>> +++ b/arch/arm/boot/dts/tegra30-beaver.dts
>> @@ -1848,7 +1848,7 @@
>>
>>   				ldo5_reg: ldo5 {
>>   					regulator-name = "vddio_sdmmc,avdd_vdac";
>
> Stephen, looking at the schematics, I don't see that this is connected
> to the avdd_vdac (which appears to be unconnected) and so I am wondering
> if this name should be just "vddio_sdmmc"?

Yes, I don't know where avdd_vdac came from; it doesn't appear connected 
on any Beaver (or even Cardhu, from which it was probably derived) 
schematic that I have.

CC += Bryan in case he has any recollection since he wrote this DT.
