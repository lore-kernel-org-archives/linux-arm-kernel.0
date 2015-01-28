From: stripathi@apm.com (Suman Tripathi)
Date: Wed, 28 Jan 2015 09:53:25 +0530
Subject: [PATCH v1 2/2] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
In-Reply-To: <CAOHikRB4tSkJsMccqHRS8XYULaP+dS7KujeSLh+ZpTxDDOF5xQ@mail.gmail.com>
References: <1422379260-10139-1-git-send-email-stripathi@apm.com>
 <1422379260-10139-3-git-send-email-stripathi@apm.com>
 <4747424.udeKOcy6tC@wuerfel>
 <CAOHikRB4tSkJsMccqHRS8XYULaP+dS7KujeSLh+ZpTxDDOF5xQ@mail.gmail.com>
Message-ID: <CAOHikRAOVMQiOy_VrXmJU1e+8KBwOFSfX1uSKvfdbVG=Br2ocg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I added the iommus in the IOMMU AHBC patch. Anything wrong in that ?
In the next version Also I will remove the IOMMU hacks from arasan
driver

On Wed, Jan 28, 2015 at 9:48 AM, Suman Tripathi <stripathi@apm.com> wrote:
> Hi Arnd,
>
> On Tuesday 27 January 2015 22:51:00 Suman Tripathi wrote:
>>
>> +               sdhc0: sdhc at 1c000000 {
>> +                       device_type = "sdhc";
>> +                       compatible = "arasan,sdhci-8.9a";
>> +                       reg = <0x0 0x1c000000 0x0 0x100>;
>> +                       interrupts = <0x0 0x49 0x4>;
>> +                       clock-names = "clk_xin", "clk_ahb";
>> +                       clocks = <&sdioclk 0>, <&ahbclk 0>;
>> +               };
>> +
>
> Here you don't provide an 'iommus' property, which means that the
> device is unable to use the iommu.
> I added the iommus in the IOMMU AHBC patch. Anything wrong in that ? In the
> next version Also I will remove the IOMMU hacks from arasan driver
>
>
> On Wed, Jan 28, 2015 at 1:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Tuesday 27 January 2015 22:51:00 Suman Tripathi wrote:
>> >
>> > +               sdhc0: sdhc at 1c000000 {
>> > +                       device_type = "sdhc";
>> > +                       compatible = "arasan,sdhci-8.9a";
>> > +                       reg = <0x0 0x1c000000 0x0 0x100>;
>> > +                       interrupts = <0x0 0x49 0x4>;
>> > +                       clock-names = "clk_xin", "clk_ahb";
>> > +                       clocks = <&sdioclk 0>, <&ahbclk 0>;
>> > +               };
>> > +
>>
>> Here you don't provide an 'iommus' property, which means that the
>> device is unable to use the iommu.
>>
>>         Arnd
>
>
>
>
> --
> Thanks,
> with regards,
> Suman Tripathi



-- 
Thanks,
with regards,
Suman Tripathi
