From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Feb 2017 08:39:30 -0600
Subject: [PATCH] arm64: dts: hisilicon: add dts files for
 hi3798cv200-poplar board
In-Reply-To: <166c4e19-f1df-e3bc-59c3-4c952f8a1cf5@hisilicon.com>
References: <1486624027-15156-1-git-send-email-xuejiancheng@hisilicon.com>
 <20170215232649.rmvdel2cyxyzuord@rob-hp-laptop>
 <166c4e19-f1df-e3bc-59c3-4c952f8a1cf5@hisilicon.com>
Message-ID: <CAL_JsqLVdrEiYyg-RVx7iz9toAtecnMdFLbbXCxjTc=b9=m01w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 3:55 AM, Jiancheng Xue
<xuejiancheng@hisilicon.com> wrote:
> Hi Rob,
>
> On 2017/2/16 7:26, Rob Herring wrote:
>> On Thu, Feb 09, 2017 at 03:07:07PM +0800, Jiancheng Xue wrote:
>>> Add basic dts files for hi3798cv200-poplar board. Poplar is the
>>> first development board compliant with the 96Boards Enterprise
>>> Edition TV Platform specification. The board features the
>>> Hi3798CV200 with an integrated quad-core 64-bit ARM Cortex A53
>>> processor and high performance Mali T720 GPU.

[...]

>>> +    soc {
>>
>> soc at 0
>>
>>> +            compatible = "simple-bus";
>>> +            #address-cells = <1>;
>>> +            #size-cells = <1>;
>>> +            ranges = <0x0 0x00000000 0x0 0xffffffff>;
>>
>> Looks like everything is within 0xf8000000-0xfa000000. Can this range be
>> further restrained?
>>
> Actually, some modules of the SoC will be added in later. This range could be restrained
> to "0xf0000000-0xffffffff". If so, should soc node be named soc at f0000000?

Yes.

Rob
