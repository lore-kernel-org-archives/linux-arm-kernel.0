From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 28 Sep 2018 19:21:45 +0200
Subject: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
In-Reply-To: <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
References: <20180910150403.19476-1-robh@kernel.org>
 <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
Message-ID: <75740733-d0d4-4c0c-838c-f01a5e7291d3@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Am 13.09.18 um 17:51 schrieb Geert Uytterhoeven:
> On Wed, Sep 12, 2018 at 3:02 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Even x86 can enable OF and OF_UNITTEST.
>>
>> Another solution might be,
>> guard it by 'depends on ARCH_SUPPORTS_OF'.
>>
>> This is actually what ACPI does.
>>
>> menuconfig ACPI
>>         bool "ACPI (Advanced Configuration and Power Interface) Support"
>>         depends on ARCH_SUPPORTS_ACPI
>>          ...
> 
> ACPI is a real platform feature, as it depends on firmware.
> 
> CONFIG_OF can be enabled, and DT overlays can be loaded, on any platform,
> even if it has ACPI ;-)

How would loading a DT overlay work on an ACPI platform? I.e., what
would it overlay against and how to practically load such a file?

I wonder whether that could be helpful for USB devices and serdev...

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
