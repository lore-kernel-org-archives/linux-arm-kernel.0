From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 7 May 2017 12:33:52 +0200
Subject: [PATCH 1/2] clk: Add bindings for the Gemini Clock Controller
In-Reply-To: <20170428182401.rpn7ytxvu6shy5sn@rob-hp-laptop>
References: <20170424185545.26608-1-linus.walleij@linaro.org>
 <20170428182401.rpn7ytxvu6shy5sn@rob-hp-laptop>
Message-ID: <CACRpkdbMTete8j0PFUnZUQBSMtu+FR+7TSwMJ-gh-Tt=hY0v+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 8:24 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Apr 24, 2017 at 08:55:45PM +0200, Linus Walleij wrote:

>> This adds device tree bindings and a header for the Gemini SoC
>> Clock Controller.
(...)
>> +- compatible : shall contain the following:
>> +  "cortina,gemini-clock-controller"
>> +- #clock-cells should be <1>
(...)
>> +Example:
>> +
>> +syscon: syscon at 40000000 {
>> +     compatible = "cortina,gemini-syscon", "syscon", "simple-mfd";
>> +     reg = <0x40000000 0x1000>;
>> +
>> +     clock-controller {
>> +             compatible = "cortina,gemini-clock-controller";
>> +             #clock-cells = <1>;
>
> There's not really much reason to have a child node here. The parent can
> be the clock provider.

But I should still keep the special clock controller compatible-string?
I guess it is also possible to just bind all the drivers to
"cortina,gemini-syscon".

Yours,
Linus Walleij
