From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 31 Dec 2013 10:12:50 +0800
Subject: [PATCH v2 2/4] ARM: dts: sun7i: external clock outputs
In-Reply-To: <20131230152552.GU3144@lukather>
References: <1388373949-28506-1-git-send-email-wens@csie.org>
 <1388373949-28506-3-git-send-email-wens@csie.org>
 <20131230152552.GU3144@lukather>
Message-ID: <CAGb2v64iDxjXX_vzvS9GyiFP64vzxnDJZHQwtFDgtx7hYqkgUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 30, 2013 at 11:25 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Mon, Dec 30, 2013 at 11:25:47AM +0800, Chen-Yu Tsai wrote:
>> This commit adds the two external clock outputs available on A20 to
>> its device tree. A dummy fixed factor clock is also added to serve as
>> the first input of the clock outputs, which according to AW's A20 user
>> manual, is the 24MHz oscillator divided by 750.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/sun7i-a20.dtsi | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
>> index 4c25f81..f255a49 100644
>> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
>> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
>> @@ -302,6 +302,33 @@
>>                       clocks = <&osc24M>, <&pll6 2>, <&pll5 1>;
>>                       clock-output-names = "mbus";
>>               };
>> +
>> +             /*
>> +              * Dummy clock used by output clocks
>> +              */
>> +             osc24M_32k: osc24M_32k {
>
> the node name should be clk to reflect the function of the device, and
> not what instance of it it might be.
>
> You should probably use something like clk at 0, to avoid collisions with
> other dummy clocks.

No problem. I will fix this and the pin mux set names.

> Note that we have pretty much the same problem already for the losc
> and osc24M, it would be great if you could do a patch for these too :)

I will add a patch before this one, so the numbering won't be confusing,
i.e. @1 appears before @0.

Mind if I add a patch enabling i2c0 on CubieTruck?
I noticed it was missing when I helped Carlo with AXP209 stuff.


Cheers

ChenYu
