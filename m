From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Mon, 7 May 2018 15:50:38 -0500
Subject: [PATCHv2 3/3] arm64: dts: stratix10: add sdram ecc
In-Reply-To: <20180507165943.GE733@pd.tnic>
References: <1524854238-19394-1-git-send-email-thor.thayer@linux.intel.com>
 <1524854238-19394-4-git-send-email-thor.thayer@linux.intel.com>
 <20180507165943.GE733@pd.tnic>
Message-ID: <CADhT+weyJFhMyPbVt0n2EVe7OpeHHLjhxjw7aY2_8GBZ-7h7Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2018 at 11:59 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Fri, Apr 27, 2018 at 01:37:18PM -0500, thor.thayer at linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Add the Stratix10 ECC Manager and SDRAM EDAC nodes to the
>> device tree.
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>> v2  Remove unused SysMan syscon
>>     Remove unused SDRAM ECC register defines
>>     Remove unused address, size and range from device tree.
>> ---
>>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>> index c89d0c307f8d..688391f3bf78 100644
>> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>> @@ -387,5 +387,17 @@
>>                       resets = <&rst WATCHDOG3_RESET>;
>>                       status = "disabled";
>>               };
>> +
>> +             eccmgr {
>> +                     compatible = "altr,socfpga-s10-ecc-manager";
>> +                     interrupts = <0 15 4>, <0 95 4>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +
>> +                     sdramedac {
>> +                             compatible = "altr,sdram-edac-s10";
>> +                             interrupts = <16 4>, <48 4>;
>> +                     };
>> +             };
>>       };
>>  };
>> --
>> 2.7.4
>>
>> --
>
> Hey Rob,
>
> ACK here too?
>
> Also, this one:
>
> https://lkml.kernel.org/r/1525203036-21774-1-git-send-email-thor.thayer at linux.intel.com
>
> ?
>

Just in case you need mine, since the edits here match what was in the
in the bindings doc.

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

Thanks,
Dinh
