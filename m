From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 3 Mar 2016 21:35:17 +0900
Subject: [rtc-linux] Re: [RFC 11/15] power: reset: keystone: Add missing
 MFD_SYSCON dependency on HAS_IOMEM
In-Reply-To: <20160303123343.GB5687@earth>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-12-git-send-email-k.kozlowski@samsung.com>
 <5230562.E0gg2SNP0m@wuerfel> <20160303123343.GB5687@earth>
Message-ID: <CAJKOXPdp=n43=foh2y-zNUnuVOmk0qK8AxjriO5Hnq-ANgpM8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-03-03 21:33 GMT+09:00 Sebastian Reichel <sre@kernel.org>:
> Hi,
>
> On Thu, Mar 03, 2016 at 12:00:14PM +0100, Arnd Bergmann wrote:
>> On Thursday 03 March 2016 17:03:37 Krzysztof Kozlowski wrote:
>> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
>> > index 0a6408a39c66..0f34846ae80d 100644
>> > --- a/drivers/power/reset/Kconfig
>> > +++ b/drivers/power/reset/Kconfig
>> > @@ -141,6 +141,7 @@ config POWER_RESET_XGENE
>> >  config POWER_RESET_KEYSTONE
>> >         bool "Keystone reset driver"
>> >         depends on ARCH_KEYSTONE
>> > +       depends on HAS_IOMEM    # For MFD_SYSCON
>> >         select MFD_SYSCON
>> >         help
>> >           Reboot support for the KEYSTONE SoCs.
>> >
>>
>> This is platform specific, but we should probably add || COMPILE_TEST
>> along with the HAS_IOMEM dependency.
>
> Sounds sensible. Will you guys send an updated patch?
>

Sure, I'll make some compile tests and send a v2.

Best regards,
Krzysztof
