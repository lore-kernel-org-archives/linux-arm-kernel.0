From: robherring2@gmail.com (Rob Herring)
Date: Tue, 24 Feb 2015 10:29:57 -0600
Subject: [PATCH] ARM64: Add new Xilinx ZynqMP SoC
In-Reply-To: <9bffa4683bd6478993de6bea1d3027af@BN1AFFO11FD048.protection.gbl>
References: <8ac3037c175711dec0adcd0d898be7d9722e0ed0.1424764548.git.michal.simek@xilinx.com>
 <CAL_JsqKkVHaf_U0nU9nqa2q5XwfsuCu-ZWVEHx6b5Mv9Hgen1Q@mail.gmail.com>
 <9bffa4683bd6478993de6bea1d3027af@BN1AFFO11FD048.protection.gbl>
Message-ID: <CAL_JsqJVdZMwweta=N-P-d=C6JNsXk0BsGcrexe2yDPm7c5pfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 8:58 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 02/24/2015 03:42 PM, Rob Herring wrote:
>> On Tue, Feb 24, 2015 at 1:56 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>>> Initial version of device tree for Xilinx ZynqMP SoC.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
>>> ---
>>
>> [...]
>>
>>> +               gic: interrupt-controller at f9010000 {
>>> +                       compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
>>
>> gic-400, right?
>
> yep
>
>>
>>> +                       #interrupt-cells = <3>;
>>> +                       reg = <0x0 0xf9010000 0x10000>,
>>> +                             <0x0 0xf9020000 0x20000>,
>>> +                             <0x0 0xf9040000 0x20000>,
>>> +                             <0x0 0xf9060000 0x20000>;
>>
>> These addresses are wrong if you are doing address swizzling to do 64K
>> offsets. We don't really have an answer yet as to what is the right
>> way. See the XGene GIC discussion[1].
>
> Is this better for GICC?
> <0x0 0xf902f000 0x2000>

Yes, and the VCPU interface needs this as well. As far as sizes, we're
still discussing that.

Rob
