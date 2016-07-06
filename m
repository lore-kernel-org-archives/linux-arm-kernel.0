From: dianders@chromium.org (Doug Anderson)
Date: Wed, 6 Jul 2016 12:47:44 -0700
Subject: [PATCH v3] arm64: dts: rockchip: add the power domain node for
 rk3399
In-Reply-To: <1904131.irFlfKsH8m@phil>
References: <1467635644-16798-1-git-send-email-wxt@rock-chips.com>
 <1904131.irFlfKsH8m@phil>
Message-ID: <CAD=FV=W8-48ODWJN=4M54nYBAzH_Bproc13kKakStL_-aLUHcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 4, 2016 at 5:24 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Am Montag, 4. Juli 2016, 20:34:04 schrieb Caesar Wang:
>> From: Elaine Zhang <zhangqing@rock-chips.com>
>>
>> In order to meet low power requirements, a power management unit (PMU) is
>> designed for controlling power resources in RK3399. The RK3399 PMU is
>> dedicated for managing the power of the whole chip.
>>
>> 1. add pd node for RK3399 Soc
>> 2. create power domain tree
>> 3. add qos node for domain
>>
>> From the DT/binds and driver can get more detail information:
>> The driver:
>>         drivers/soc/rockchip/pm_domains.c
>> The document:
>>         Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>>
>> Note:
>> As the TRM lists many voltage domains and power domains, then this patch
>> adds some domains for driver. Due to some domains
>> (e.g. emmc, usb, core)...We can't turned off it on
>> bootup, or says some device driver can't handle the power domain enough.
>> Maybe We will add more other domains in the future or later.
>
> I talked with Caesar about that today and for example the gmac domain seems
> to cause problems right now when only using the generic power-domain
> handling the kernel provides on probe and remove.
>
> So while this gets investigated, I'm probably ok with only using the stable
> power-domains, but will give the us-people a chance to also respond on
> wednesday :-) .

Sure, that's fine with me.  Walk before we run.  ;)

-Doug
