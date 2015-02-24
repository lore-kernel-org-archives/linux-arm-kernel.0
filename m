From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 24 Feb 2015 15:58:47 +0100
Subject: [PATCH] ARM64: Add new Xilinx ZynqMP SoC
In-Reply-To: <CAL_JsqKkVHaf_U0nU9nqa2q5XwfsuCu-ZWVEHx6b5Mv9Hgen1Q@mail.gmail.com>
References: <8ac3037c175711dec0adcd0d898be7d9722e0ed0.1424764548.git.michal.simek@xilinx.com>
 <CAL_JsqKkVHaf_U0nU9nqa2q5XwfsuCu-ZWVEHx6b5Mv9Hgen1Q@mail.gmail.com>
Message-ID: <9bffa4683bd6478993de6bea1d3027af@BN1AFFO11FD048.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2015 03:42 PM, Rob Herring wrote:
> On Tue, Feb 24, 2015 at 1:56 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> Initial version of device tree for Xilinx ZynqMP SoC.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
>> ---
> 
> [...]
> 
>> +               gic: interrupt-controller at f9010000 {
>> +                       compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
> 
> gic-400, right?

yep

> 
>> +                       #interrupt-cells = <3>;
>> +                       reg = <0x0 0xf9010000 0x10000>,
>> +                             <0x0 0xf9020000 0x20000>,
>> +                             <0x0 0xf9040000 0x20000>,
>> +                             <0x0 0xf9060000 0x20000>;
> 
> These addresses are wrong if you are doing address swizzling to do 64K
> offsets. We don't really have an answer yet as to what is the right
> way. See the XGene GIC discussion[1].

Is this better for GICC?
<0x0 0xf902f000 0x2000>

Thanks,
Michal
