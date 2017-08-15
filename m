From: rafal@milecki.pl (=?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=)
Date: Tue, 15 Aug 2017 08:42:11 +0200
Subject: [PATCH v4 2/4] thermal: add brcmstb AVS TMON driver
In-Reply-To: <1502777298.2591.1.camel@intel.com>
References: <20170809220257.4234-1-code@mmayer.net>
 <20170809220257.4234-3-code@mmayer.net> <1502777298.2591.1.camel@intel.com>
Message-ID: <95da51df3cadbb05f721f2e5b8d59f8d@milecki.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-08-15 08:08, Zhang Rui wrote:
>> diff --git a/drivers/thermal/broadcom/Kconfig
>> b/drivers/thermal/broadcom/Kconfig
>> index 42c098e..c106a15 100644
>> --- a/drivers/thermal/broadcom/Kconfig
>> +++ b/drivers/thermal/broadcom/Kconfig
>> @@ -6,6 +6,13 @@ config BCM2835_THERMAL
>> ?	help
>> ?	??Support for thermal sensors on Broadcom bcm2835 SoCs.
>> ?
>> +config BRCMSTB_THERMAL
>> +	tristate "Broadcom STB AVS TMON thermal driver"
>> +	depends on ARCH_BRCMSTB || COMPILE_TEST
>> +	help
>> +	??Enable this driver if you have a Broadcom STB SoC and
>> would like
>> +	??thermal framework support.
>> +
> 
> I don't understand why I got the following checkpatch warning
> 
> WARNING: please write a paragraph that describes the config symbol
> fully
> #73: FILE: drivers/thermal/broadcom/Kconfig:9:
> +config BRCMSTB_THERMAL
> 
> I didn't see this for other Kconfig changes.

It's because your help message is only 2 lines long (instead of 3).

Some (many?) maintainers aren't pedantic about that, a common sense 
should
be applied ;)
