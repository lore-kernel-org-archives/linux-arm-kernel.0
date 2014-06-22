From: tthayer.linux@gmail.com (Thor Thayer)
Date: Sun, 22 Jun 2014 13:31:02 -0500
Subject: [PATCHv6 1/3] devicetree: Addition of the Altera SDRAM controller
In-Reply-To: <20140621090446.GA8053@pengutronix.de>
References: <1403306523-4174-2-git-send-email-tthayer@altera.com>
 <20140621090446.GA8053@pengutronix.de>
Message-ID: <CAF03EBeUdrqfjOPCf4XxaKL_ZSqAcrgSbpDfTKov9_5oG4-Btg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 21, 2014 at 4:04 AM, Steffen Trumtrar
<s.trumtrar@pengutronix.de> wrote:
> Hi!
>
> On Fri, Jun 20, 2014 at 06:22:01PM -0500, tthayer at altera.com wrote:
>> From: Thor Thayer <tthayer@altera.com>
>>
>> Addition of the Altera SDRAM Controller bindings and device tree changes.
>>
>> v2: Changes to SoC SDRAM EDAC code.
>>
>> v3: Implement code suggestions for SDRAM EDAC code.
>>
>> v4: Remove syscon from SDRAM controller bindings.
>>
>> v5: No Change, bump version for consistency.
>>
>> v6: Only map the ctrlcfg register as syscon.
>>
>> Signed-off-by: Thor Thayer <tthayer@altera.com>
>> ---
>>  .../bindings/arm/altera/socfpga-sdram.txt          |   11 +++++++++++
>>  arch/arm/boot/dts/socfpga.dtsi                     |    5 +++++
>>  2 files changed, 16 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
>> new file mode 100644
>> index 0000000..5027026
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
>> @@ -0,0 +1,11 @@
>> +Altera SOCFPGA SDRAM Controller
>> +
>> +Required properties:
>> +- compatible : "altr,sdr-ctl";
>> +- reg : Should contain 1 register ranges(address and length)
>> +
>> +Example:
>> +     sdrctl at ffc25000 {
>> +             compatible = "altr,sdr-ctl";
>> +             reg = <0xffc25000 0x4>;
>> +     };
>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>> index 4676f25..310292e 100644
>> --- a/arch/arm/boot/dts/socfpga.dtsi
>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>> @@ -682,6 +682,11 @@
>>                       clocks = <&l4_sp_clk>;
>>               };
>>
>> +             sdrctl at ffc25000 {
>> +                     compatible = "altr,sdr-ctl", "syscon";
>
> Did you forget to add the syscon to the binding documentation?
>
Hi Steffen,

I guess I'm confused about when to use syscon. In my last series, I
was advised not to include syscon in the bindings but to use it in the
device tree. I had been including it in the binding document until
this patch.

Thanks,

Thor
>> +                     reg = <0xffc25000 0x4>;
>> +             };
>> +
>>               rst: rstmgr at ffd05000 {
>>                       compatible = "altr,rst-mgr";
>>                       reg = <0xffd05000 0x1000>;
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
