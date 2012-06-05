From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 05 Jun 2012 11:31:24 +0100
Subject: [PATCH 08/22] regulator: Change ab8500 match names to reflect
 Device Tree
In-Reply-To: <20120601084850.GJ24139@opensource.wolfsonmicro.com>
References: <1338353260-10097-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdbQv8Q07iRAmG3UQRm7UNDi_Y+s_vvACDKKxR9tg+1iqg@mail.gmail.com>
 <20120530100302.GD9947@opensource.wolfsonmicro.com>
 <CAF2Aj3gZMF9ev9B46rBM+aY-srwthef09ad2CWfuXXFHmqqAjA@mail.gmail.com>
 <20120530121547.GJ9947@opensource.wolfsonmicro.com>
 <4FC63632.4030504@linaro.org>
 <20120530151119.GN9947@opensource.wolfsonmicro.com>
 <4FC63B39.6040905@linaro.org>
 <20120530164152.GP9947@opensource.wolfsonmicro.com>
 <4FC846CC.20801@linaro.org>
 <20120601084850.GJ24139@opensource.wolfsonmicro.com>
Message-ID: <4FCDDFFC.3000902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/12 09:48, Mark Brown wrote:
> On Fri, Jun 01, 2012 at 12:36:28PM +0800, Lee Jones wrote:
>
>> This:
>
>>> sdi at 80126000 {
>>>          vmmc-supply =<&ab8500_ldo_aux3_reg>;
>>> };
>
>> Is the same as, and will cause no more issues than:
>
>>> static struct regulator_consumer_supply ab8500_vaux3_consumers[] = {
>>>         REGULATOR_SUPPLY("vmmc", "sdi0"),
>>> };
>
>> ... because only nodes which we care about (dictated by compatible
>> declaration protections) will be parsed. So different platforms will
>> not affect each other.
>
> What makes you say the two are equivalent?  The former is a reference
> from a consumer device to a named regulator while the latter is a
> reference from a regulator to a named consumer.

I mean they both link regulator<->consumer and apply the name "vmmc" to 
the supply, or am I missing something / getting confused?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
