From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 25 Sep 2017 21:13:57 -0700
Subject: [PATCH v4 2/4] thermal: add brcmstb AVS TMON driver
In-Reply-To: <744357E9AAD1214791ACBA4B0B9092636BE1FB55@SHSMSX101.ccr.corp.intel.com>
References: <20170809220257.4234-1-code@mmayer.net>
 <20170809220257.4234-3-code@mmayer.net> <1502777298.2591.1.camel@intel.com>
 <95da51df3cadbb05f721f2e5b8d59f8d@milecki.pl>
 <1502779721.2591.4.camel@intel.com>
 <4ec0715e-fcd7-3aec-3589-96426575c373@gmail.com>
 <744357E9AAD1214791ACBA4B0B9092636BE1FB55@SHSMSX101.ccr.corp.intel.com>
Message-ID: <1e23383c-7c63-04fc-0f07-21b0e418e3de@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2017 08:02 PM, Zhang, Rui wrote:
> Hi, Florian,
> 
> This patch set was dropped in the last minute because of this discussion
> https://patchwork.kernel.org/patch/9936325/
> as I don?t want to rebase the patch before sending the pull request.

Ah, you wanted to squash that patch into the initial submission?

> 
> I don?t think we can make it for 4.14.
> Eduardo will be back and pick the soc patches for 4.15.

I assume you would want to get that particular patch squashed into a
clean submission targeting 4.15 now, right?

Thanks

> 
> Thanks,
> rui
> 
> 
> 
> -----Original Message-----
> From: Florian Fainelli [mailto:f.fainelli at gmail.com] 
> Sent: Monday, September 25, 2017 5:11 AM
> To: Zhang, Rui <rui.zhang@intel.com>; Rafa? Mi?ecki <rafal@milecki.pl>
> Cc: Markus Mayer <code@mmayer.net>; Eduardo Valentin <edubezval@gmail.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Doug Berger <opendmb@gmail.com>; Brian Norris <computersforpeace@gmail.com>; Gregory Fong <gregory.0xf0@gmail.com>; Russell King <linux@armlinux.org.uk>; Catalin Marinas <catalin.marinas@arm.com>; Will Deacon <will.deacon@arm.com>; Arnd Bergmann <arnd@arndb.de>; Olof Johansson <olof@lixom.net>; Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>; Power Management List <linux-pm@vger.kernel.org>; Device Tree List <devicetree@vger.kernel.org>; ARM Kernel List <linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Markus Mayer <mmayer@broadcom.com>
> Subject: Re: [PATCH v4 2/4] thermal: add brcmstb AVS TMON driver
> Importance: High
> 
> Le 08/14/17 ? 23:48, Zhang Rui a ?crit?:
>> On Tue, 2017-08-15 at 08:42 +0200, Rafa? Mi?ecki wrote:
>>> On 2017-08-15 08:08, Zhang Rui wrote:
>>>>
>>>>>
>>>>> diff --git a/drivers/thermal/broadcom/Kconfig
>>>>> b/drivers/thermal/broadcom/Kconfig
>>>>> index 42c098e..c106a15 100644
>>>>> --- a/drivers/thermal/broadcom/Kconfig
>>>>> +++ b/drivers/thermal/broadcom/Kconfig
>>>>> @@ -6,6 +6,13 @@ config BCM2835_THERMAL
>>>>> ?	help
>>>>> ?	??Support for thermal sensors on Broadcom bcm2835 SoCs.
>>>>> ?
>>>>> +config BRCMSTB_THERMAL
>>>>> +	tristate "Broadcom STB AVS TMON thermal driver"
>>>>> +	depends on ARCH_BRCMSTB || COMPILE_TEST
>>>>> +	help
>>>>> +	??Enable this driver if you have a Broadcom STB SoC and
>>>>> would like
>>>>> +	??thermal framework support.
>>>>> +
>>>> I don't understand why I got the following checkpatch warning
>>>>
>>>> WARNING: please write a paragraph that describes the config symbol 
>>>> fully
>>>> #73: FILE: drivers/thermal/broadcom/Kconfig:9:
>>>> +config BRCMSTB_THERMAL
>>>>
>>>> I didn't see this for other Kconfig changes.
>>> It's because your help message is only 2 lines long (instead of 3).
>>>
>>> Some (many?) maintainers aren't pedantic about that, a common sense 
>>> should be applied ;)
>>
>> thanks for explaining.
>> Patch 1 and 2 queued for next merge window.
> 
> Humm, I don't see this driver in your latest 4.14 pull request to Linus, so what happened here exactly? Can we expect this driver to be submitted for 4.14 or we just happened to have missed this window now?
> --
> Florian
> 

-- 
Florian
