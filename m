From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 20 May 2017 10:45:02 +0200
Subject: [PATCH 1/2] ARM: dts: meson: organize devices in their
 corresponding busses
In-Reply-To: <m2inkw4g47.fsf@baylibre.com>
References: <20170417213938.22626-1-martin.blumenstingl@googlemail.com>
 <20170417213938.22626-2-martin.blumenstingl@googlemail.com>
 <m2inkw4g47.fsf@baylibre.com>
Message-ID: <CAFBinCBcWgS_qSMNEUH+QrPXxLyQo87paH3+wBkHf5LWarnmEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 20, 2017 at 12:49 AM, Kevin Hilman <khilman@baylibre.com> wrote:
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
>> The Amlogic Meson SoCs have most of the internal peripherals organized
>> in busses. Use them to make the dts easier to read and to avoid
>> duplicated register (bus) offset definitions.
>>
>> The bus information is taken from the vendor kernel:
>>       #define IO_CBUS_PHY_BASE        0xc1100000  ///2M
>>       #define IO_AOBUS_PHY_BASE       0xc8100000  ///1M
>>
>> There are more internal busses (such as the abp bus which seems to
>> contain audio, HDMI and Mali registers), but since we don't have
>> drivers for them yet these are not added (yet).
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> I tested this series on my meson8b-odroidc1 and it boots fine.
>
> Series looks fine to me, except...
>
> [...]
>
>>
>>               ethmac: ethernet at c9410000 {
>>                       compatible = "amlogic,meson6-dwmac", "snps,dwmac";
>>                       reg = <0xc9410000 0x10000
>> -                            0xc1108108 0x4>;
>> +                     0xc1108108 0x4>;
>
> stray tab removal?
oh, excellent catch - thank you!

> I fixed that up locally and applied to v4.13/dt64 branch.
nice, thank you!

do the ARM maintainers still want separate pull-requests for 32-bit
and 64-bit .dts/defconfig/etc. changes?
you might want to move the three latest commits from v4.13/dt64 to
v4.13/dt32 in that case, but this should be trivial (since these
patches don't depend on anything else)

> Thanks for the patches!
you're welcome, hopefully more to follow!


Regards,
Martin
