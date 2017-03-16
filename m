From: moritz.fischer.private@gmail.com (Moritz Fischer)
Date: Thu, 16 Mar 2017 09:39:44 -0700
Subject: [PATCH v2] ARM: zynq: Add #io-channel-cells to (x)adc node for
 iio-hwmon
In-Reply-To: <e6da3f38-7039-66e5-5b9d-a44ff42aa9c9@xilinx.com>
References: <1489003884-2489-1-git-send-email-mdf@kernel.org>
 <e6da3f38-7039-66e5-5b9d-a44ff42aa9c9@xilinx.com>
Message-ID: <CAJYdmeNc48=OOvRiUjqPBJhz9RCbzeaRGu1Tfm=hrvzkJrSsag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 9:16 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> Hi,
>
> On 8.3.2017 21:11, Moritz Fischer wrote:
>> Fix
>>
>> OF: /iio_hwmon: could not get #io-channel-cells for
>> /amba/adc at f8007100
>> OF: /iio_hwmon: could not get #io-channel-cells for
>> /amba/adc at f8007100
>> OF: /iio_hwmon: could not get #io-channel-cells for
>> /amba/adc at f8007100
>>
>> by adding the #io-channel-cells property.
>>
>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
>> Cc: Julia Cartwright <julia@ni.com>
>> Cc: linux-kernel at vger.kernel.org
>> Cc: devicetree at vger.kernel.org
>> ---
>>
>> Changes from v1:
>> - fix messed up commit message
>> ---
>>  arch/arm/boot/dts/zynq-7000.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>> index f3ac9bf..98233a8 100644
>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>> @@ -72,6 +72,7 @@
>>                       interrupts = <0 7 4>;
>>                       interrupt-parent = <&intc>;
>>                       clocks = <&clkc 12>;
>> +                     #io-channel-cells = <1>;
>>               };
>>
>>               can0: can at e0008000 {
>>
>
> I think it will be good to the next step too.
> It means also add iio-hwmon node too.
>
> What do you think?

I hadn't put it in there since dts is supposed to describe hw,
but obviously putting the actual hwmon in there makes it more useful.

I can resubmit with the hwmon node in there.

Cheers,
Moritz
