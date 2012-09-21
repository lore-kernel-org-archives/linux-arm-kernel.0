From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Sep 2012 10:19:45 -0600
Subject: [PATCH v2 5/5] ARM: tegra: enable brcmfmac in defconfig
In-Reply-To: <505C7C27.2050108@broadcom.com>
References: <1348217700-12309-1-git-send-email-wni@nvidia.com>
 <1348217700-12309-6-git-send-email-wni@nvidia.com>
 <505C7C27.2050108@broadcom.com>
Message-ID: <505C93A1.2040801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2012 08:39 AM, Arend van Spriel wrote:
> On 09/21/2012 10:55 AM, Wei Ni wrote:
>> New options enabled:
>> * CFG80211_WEXT: (dependency)
>> * BRCMFMAC: wlan driver, enable as module.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>   arch/arm/configs/tegra_defconfig |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/configs/tegra_defconfig
>> b/arch/arm/configs/tegra_defconfig
>> index adcf3c2..04b18ea 100644
>> --- a/arch/arm/configs/tegra_defconfig
>> +++ b/arch/arm/configs/tegra_defconfig
>> @@ -73,6 +73,7 @@ CONFIG_BT_BNEP=y
>>   CONFIG_BT_HIDP=y
>>   CONFIG_BT_HCIBTUSB=m
>>   CONFIG_CFG80211=y
>> +CONFIG_CFG80211_WEXT=y
> 
> Any particular reason for enabling this? The driver does not
> specifically need it. The option only allows use of WEXT dependent
> user-space tools like iwconfig and iwlist. At least it is not needed by
> brcmfmac driver hence it does not select it.
> 
> You indicate there is a dependency. Could you elaborate?

"Dependency" probably isn't correct.

However, the intent of tegra_defconfig is to provide a useful
configuration for Tegra boards. Without the ability to use
iwconfig/iwlist, enabling the wireless driver doesn't seem useful; how
would someone configure the wireless connection?
