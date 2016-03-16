From: ddaney@caviumnetworks.com (David Daney)
Date: Wed, 16 Mar 2016 15:54:50 -0700
Subject: [PATCH v2 3/3] phy: mdio-thunder: Add driver for Cavium Thunder
 SoC MDIO buses.
In-Reply-To: <56E9E343.3080207@suse.de>
References: <1457718791-6505-1-git-send-email-ddaney.cavm@gmail.com>
 <1457718791-6505-4-git-send-email-ddaney.cavm@gmail.com>
 <56E9E343.3080207@suse.de>
Message-ID: <56E9E43A.6000304@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/2016 03:50 PM, Andreas F?rber wrote:
> Hi,
>
> Am 11.03.2016 um 18:53 schrieb David Daney:
>> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
>> index 40faec9..075a4cc 100644
>> --- a/drivers/net/phy/Kconfig
>> +++ b/drivers/net/phy/Kconfig
>> @@ -196,6 +196,17 @@ config MDIO_OCTEON
>>   	  buses. It is required by the Octeon and ThunderX ethernet device
>>   	  drivers on some systems.
>>
>> +config MDIO_THUNDER
>> +	tristate "Support for MDIO buses on on ThunderX SOCs"
>
> Double "on", spotted in next-20160316.
>
>> +	depends on 64BIT
>> +	depends on PCI
>> +	select MDIO_CAVIUM
>> +	help
>> +	  This driver supports the MDIO interfaces found on Cavium
>> +	  ThunderX SoCs when the MDIO bus device appears on as a PCI
>> +	  device.
>
> While at it, this sentence sounds weird. Did you mean s/as/is/? Or is
> there another verb missing in there?

Should be "... appears as a PCI device."

davem already merged the patch, so this would have to be fixed as a 
follow-on patch.

Since you found this, do you want to send the patch?

Thanks,
David Daney

>
> Regards,
> Andreas
>
>> +
>> +
>>   config MDIO_SUN4I
>>   	tristate "Allwinner sun4i MDIO interface support"
>>   	depends on ARCH_SUNXI
> [snip]
>
