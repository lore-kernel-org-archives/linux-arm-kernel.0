From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 May 2017 17:47:12 +0200
Subject: [PATCH 1/2 v2] clk: Add bindings for the Gemini Clock Controller
In-Reply-To: <CAL_Jsq+WQijqm43U_SzSVzCn6_eeFLjggcWnbwbCpW99ct4XOQ@mail.gmail.com>
References: <20170508201159.31634-1-linus.walleij@linaro.org>
 <CAL_JsqLAMObobPrBDdA8bjaKTX4rEo2=_qd86ibbA2kQP6AvBg@mail.gmail.com>
 <CACRpkdY+EzbbTy6PzN5-YhCnSxPoKej2z=t-7eC3CPqDa6Q4_w@mail.gmail.com>
 <CAL_Jsq+WQijqm43U_SzSVzCn6_eeFLjggcWnbwbCpW99ct4XOQ@mail.gmail.com>
Message-ID: <CACRpkdbMqwGj3gx1h_GXy1xxkxeEgj6LTy1y8rd04WRorGSymg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 9, 2017 at 4:23 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Mon, May 8, 2017 at 4:41 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Mon, May 8, 2017 at 11:24 PM, Rob Herring <robh+dt@kernel.org> wrote:
>>
>>>> +Example:
>>>> +
>>>> +syscon: syscon at 40000000 {
>>>> +       compatible = "cortina,gemini-syscon", "cortina,gemini-clock-controller",
>>>> +                    "syscon", "simple-mfd";
>>>
>>> There are no child nodes, so you don't need simple-mfd.
>>
>> The example is taken from an actual device tree (look below),
>> where there are child nodes, I can trim it down.
>>
>>>> +       reg = <0x40000000 0x1000>;
>>>
>>> Looks like you have 2 nodes pointing to the same address with your
>>> reset binding? You shouldn't have overlapping resources. It's allowed
>>> for historical reasons but breaks resource creation in Linux.
>>
>> No... they are all in the same node, just sharing the same
>> resource by way of regmap (syscon).
>
> Okay, then please document at least the parent syscon node in a single
> doc. Splitting it is very confusing.

I'm sorry. :(

I'll patch the document in arm/gemini.txt
where the syscon node is documented, with a single patch adding
both clock and reset bindings.

>>                 syscon: syscon at 40000000 {
>>                         compatible = "cortina,gemini-syscon",
>>                                      "cortina,gemini-clock-controller",
>>                                      "cortina,gemini-reset",
>
> This mostly looks fine, but you shouldn't need 3 compatible strings
> for the block.

OK I'll see if I can make it work with just "cortina,gemini-syscon"
and skip the two others.

Yours,
Linus Walleij
