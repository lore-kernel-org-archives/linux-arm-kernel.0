From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Nov 2015 15:55:16 +0100
Subject: Strange message from Kirkwood pinctrl driver
In-Reply-To: <20151125144645.GE11384@lunn.ch>
References: <CACRpkdah4w-=qHS+q_=Ab-RiJyvbCKY-Rp5Ya0x+F=3DL2iuBA@mail.gmail.com>
 <20151125144645.GE11384@lunn.ch>
Message-ID: <CACRpkdbi=iCV1B=u60mNqRWhcgAcs33J-DeB-C=r+2v1eLPbpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 3:46 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, Nov 25, 2015 at 11:27:46AM +0100, Linus Walleij wrote:
>> Hi Sebastian,
>>
>> trying to use the Kirkwood pinctrl driver with compatible =
>> "marvell,88f6192-pinctrl";
>> on a Pogoplug series 4 yields the following message when instantiating
>> the driver:
>>
>> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 36
>> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 37
>> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 38
>> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 39
>> kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 40
>
> Hi Linus
>
> Humm, interesting. I don't remember it doing that before. I will look
> into this in the next couple of days.

There are only few devices using it: it is declared in
kirkwood-6192.dtsi and that is just used by:

kirkwood-blackarmor-nas220.dts
kirkwood-laplug.dts
kirkwood-rd88f6192.dts
... and my new device tree

Interestingly, kirkwood-ns2[lite|mini].dts specifies it's compatible
with "marvell,kirkwood-88f6192" but instead includes
kirkwood-ns2-common.dtsi which includes
kirkwood-6281.dtsi. I haven't wrapped my head around that
one, I suspect it's a bug.

Yours,
Linus Walleij
