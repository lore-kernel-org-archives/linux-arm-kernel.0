From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Dec 2017 10:38:58 +0100
Subject: [RFC PATCH 1/3] dt-bindings: pinctrl: sunxi: document new generic
 binding
In-Reply-To: <0c8051e6-5d8c-32d6-97e4-11c2283da5b4@arm.com>
References: <20171113012523.2328-1-andre.przywara@arm.com>
 <20171113012523.2328-2-andre.przywara@arm.com>
 <CACRpkdbpfkM4odz425+4qyUCF5vqPWBQ=F5Yk7AtJL5SqXghpg@mail.gmail.com>
 <20171124105240.GB3792@ulmo> <20efcf8f-85a5-3cad-a84b-434ee5cad68e@arm.com>
 <20171124133123.GA15999@ulmo> <0c8051e6-5d8c-32d6-97e4-11c2283da5b4@arm.com>
Message-ID: <CACRpkdZccQ98Qbw9BvAQZESc9X4UcY9DPz4LngzrhAHT78nSxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 6:19 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> On 24/11/17 13:31, Thierry Reding wrote:

>> Register values don't belong in a device tree.
>
> I don't think that's true in a general way. This "pinmux" is already an
> accepted property and used for exactly that purpose in other pinctrl
> drivers:
> $ git grep -l '[^,]pinmux = ' arch/arm{,64}/boot/dts
> Plus the fsl,pinmux-ids property, which seems to serve the same purpose.

There are several examples of register values (and register
numbers even!) being encoded in the kernel.

What we need to ask is whether that is good in the general case
or bad. I don't even think that has a clear answer, it's a grey area.

So we need to avoid "arguments from consistency" which reads
something like "you allowed this thing A so now you must allow
this thing B which is similar". It is not a helpful approach to the
problem.

Some drivers encode a bunch of data into the device tree,
pinctrl-single is the most extreme. This conflict between in-DT
and in-driver data storage has been there since pinctrl was created
and was the result of a compromise between OMAPs needs
and everyone else, especially Tegra.

The opinions on this - and it is really opinions, not facts - differ
between people and over time.

Resolving the conflicts is more about classical diplomacy than
science unfortunately. I used to think the christian trinity was
amusing and inconsistent, but nowadays I understand exactly how
the people who came up with the Nicean creed were reasoning.

What is paramount for me as subsystem maintainer is the fact
that this driver has an active maintainer. And maintainers
is what makes things manageable for me. It would be much easier
for you to have your way if you were submitting an entirely
new driver. Like this pinmux property, it was submitted by the
mediatek people because it fits their usecase/hardware especially
well.

Yours,
Linus Walleij
