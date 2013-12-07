From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 8 Dec 2013 00:20:18 +0800
Subject: [PATCH 10/10] ARM: dts: sun7i: Add ethernet alias for GMAC
In-Reply-To: <20131207101510.GJ24519@lukather>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-11-git-send-email-wens@csie.org>
 <20131207101510.GJ24519@lukather>
Message-ID: <CAGb2v65uX8tgsBuSsnCOJ=qTeqjBXC3aRTJrk53gbJfJQqWXtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I will rebase onto 3.13-rc3 or 3.13 when it comes out.

On Sat, Dec 7, 2013 at 6:15 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Chen-Yu,
>
> On Sat, Dec 07, 2013 at 01:29:43AM +0800, Chen-Yu Tsai wrote:
>> U-Boot will insert MAC address into the device tree image.
>> It looks up ethernet[0-5] aliases to find the ethernet nodes.
>> Alias GMAC as ethernet0, as it is the only ethernet controller used.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/sun7i-a20.dtsi | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
>> index 64b1391..f7c57c6 100644
>> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
>> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
>> @@ -16,6 +16,10 @@
>>  / {
>>       interrupt-parent = <&gic>;
>>
>> +     aliases {
>> +             ethernet0 = &gmac;
>> +     };
>> +
>
> Actually, it conflicts with
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/211695.html
>
> Please rebase accordingly.
>
> Thanks,
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
