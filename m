From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 13 Jun 2012 13:28:17 +0100
Subject: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C
 driver
In-Reply-To: <CACRpkdZC8E6izDpdnWy6DMjOdA6KsqTaPoaq9pErWoNW0Ewytw@mail.gmail.com>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
 <4FD6F0E8.5040606@linaro.org>
 <CACRpkdYxiT-0x4aetMxB2x8SkB+Mmy8rk8uSzgU_anemSayhMw@mail.gmail.com>
 <4FD83AAD.2010701@linaro.org>
 <CACRpkdZC8E6izDpdnWy6DMjOdA6KsqTaPoaq9pErWoNW0Ewytw@mail.gmail.com>
Message-ID: <4FD88761.9050703@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/12 09:12, Linus Walleij wrote:
> On Wed, Jun 13, 2012 at 9:01 AM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> Board specific is fine, as the data is protected by a board specific
>> property. Do you mean that the properties are *bus specific*? In which case
>> I see your point and will apply the correct bindings.
>
> I cannot parse this, the board for me is a SoC, busses and a
> number of components connected via e.g. I2C.
>
> Can you define what you mean with a "board specific property"?
> It seems you are talking about what I would call an
> "SoC-specific property", i.e. something out of a .dtsi file for
> a certain SoC, whereas the .dts for an entire board is,
> well, for a board, a set of components on a PCB.
>
> The arrangement of accelerometers and battery monitors on a
> certain board is board-specific, and it is also by definition
> bus-specific.

Okay, let's put it another way. We can individualise any board, bus, 
platform, machine or system by placing all of the information in a DT 
node so long as we plonk it in the correct place within the Device Tree. 
However, we have just as much control by keeping them in separate 
structs in the C file and selecting the right one using the compatible 
sting.

The real item for discussion is; if we have varying configurations for 
each of the i2c buses residing on the same SoC, do we really want to use 
different compatible strings to identify each one. If the answer is no, 
which I think it is, then I need to write the bindings and have 
everything individually configurable from Device Tree.

While you're mulling this over, I'm just going to write the bindings anyway.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
