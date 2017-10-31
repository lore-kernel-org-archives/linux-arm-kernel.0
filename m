From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 Oct 2017 14:27:13 +0100
Subject: [PATCH] pinctrl: armada-37xx: Add edge both type gpio irq support
In-Reply-To: <20171031131617.GA11647@lunn.ch>
References: <20171019131003.9684-1-gregory.clement@free-electrons.com>
 <CACRpkdbqjh5U5QoE_B+7GfSyDdHW-NCAvogGq-2n8j6L6nG-Gw@mail.gmail.com>
 <20171031131617.GA11647@lunn.ch>
Message-ID: <CACRpkdZxWwXcB8o4+gsYN+mnoQvE7eT5sPOO1mKNuELuo7T70g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 2:16 PM, Andrew Lunn <andrew@lunn.ch> wrote:

>> The discussion here is interesting, it is customary for GPIO drivers
>> to implement double-edge detection emulation by swapping the
>> edge detector around like this.
>
> Hi Linus
>
> I was not aware this was customary.
>
>> It might be possible to collect some generic information about
>> this in the Documentation/gpio/driver.txt document.
>
> Yes, i think it should be documented somewhere. Even in the use case
> here, detecting an SD card being inserted/removed, you could get some
> bounce on the microswitch, miss an edge, and be in the wrong state.

Indeed :/

This is I guess why it is a good idea to combine this with the
debounce feature if the hardware supports it.

I'll think about some writeup.

Yours,
Linus Walleij
