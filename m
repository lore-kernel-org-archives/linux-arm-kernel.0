From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 11 Feb 2014 12:25:17 +0900
Subject: [PATCH 1/3] arm64: dts: add initial dts for Samsung GH7 SoC and
 SSDK-GH7 board
In-Reply-To: <CAOesGMjE=zOStKoZQhYLhYtL_aWD73DcF4w6STboZPMfHkLtxA@mail.gmail.com>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
 <1392100183-30930-2-git-send-email-kgene.kim@samsung.com>
 <CAOesGMjE=zOStKoZQhYLhYtL_aWD73DcF4w6STboZPMfHkLtxA@mail.gmail.com>
Message-ID: <52F9981D.8060204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/14 08:36, Olof Johansson wrote:
> Hi,
>
Hi Olof,

> Besides what Mark Rutland already commented on:
>
OK, thanks :-)

> On Mon, Feb 10, 2014 at 10:29 PM, Kukjin Kim<kgene.kim@samsung.com>  wrote:
>> +/ {
>> +       model = "SAMSUNG GH7";
>> +       compatible = "samsung,gh7";
>
> Model and compatible in the dtsi should probably always be overridden
> by a dts that includes it, so there's little use in having it here.
>
OK, makes sense.

>> +       interrupt-parent =<&gic>;
>> +       #address-cells =<2>;
>> +       #size-cells =<2>;
>> +
>> +       cpus {
>> +               #address-cells =<2>;
>> +               #size-cells =<0>;
>> +
>> +               cpu at 000 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,armv8";
>> +                       reg =<0x0 0x000>;
>
> No need to zero-pad cpu numbers in unit address or reg.
>
Yes it's correct without any consideration, but I'm going to add more 
cpus next time and they should be separated from this. So I used.

>> +                       enable-method = "spin-table";
>> +                       cpu-release-addr =<0x0 0x8000fff8>;
>> +               };
>> +               cpu at 001 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,armv8";
>> +                       reg =<0x0 0x001>;
>> +                       enable-method = "spin-table";
>> +                       cpu-release-addr =<0x0 0x8000fff8>;
>> +               };
>> +               cpu at 002 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,armv8";
>> +                       reg =<0x0 0x002>;
>> +                       enable-method = "spin-table";
>> +                       cpu-release-addr =<0x0 0x8000fff8>;
>> +               };
>> +               cpu at 003 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,armv8";
>> +                       reg =<0x0 0x003>;
>> +                       enable-method = "spin-table";
>> +                       cpu-release-addr =<0x0 0x8000fff8>;
>> +               };
>> +       };
>> +
>> +       gic: interrupt-controller at 1C000000 {
>> +               compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
>
> This looks incorrect -- you should at the very least have a more
> specific one than a15-gic? Marc?
>
OK, you're right. And I replied on other e-mail.

Thanks,
Kukjin
