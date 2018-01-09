From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Jan 2018 15:47:37 +0100
Subject: [PATCH] ARM: realview: remove eb-mp clcd IRQ
In-Reply-To: <3cc1ad94-0a62-2f35-d204-2b89b8ba642b@arm.com>
References: <20171221213146.3146805-1-arnd@arndb.de>
 <CACRpkdbCWZB1ZkrdGe0s0GfNVWEYY+NThy4ce-+SBtU-s=WNbQ@mail.gmail.com>
 <3cc1ad94-0a62-2f35-d204-2b89b8ba642b@arm.com>
Message-ID: <CACRpkdY-6Djmofix1BhFEwnKAD3wC7PkqKCiJVFbWvseaXxO3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 8, 2018 at 5:31 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 21/12/17 22:08, Linus Walleij wrote:

>> I do think the reference design has a character LCD, and I
>> do think it has an interrupt, it's just undocumented so
>> someone with this board would have to test it manually
>> to figure out which line it is. Whoever uses this design
>> will get to it if ever.
>
> FWIW the EB baseboard is *physically* the same regardless of the CPU, it's
> just flashed with a Core-Tile-specific FPGA bitstream.

Aha I always wondered how that works :)

> I've just tried
> firing up an 11MPCore one, and indeed the character LCD does light up with
> the kernel version. I can't convince the recalcitrant beast to actually get
> to userspace, though, so I can't confirm what the interrupt's deal is.

Yeah the driver survives fine without an IRQ too so it just works ...

> The baseboard manual (DUI0303E) says it's interrupt 22 on the board-level
> secondary GICs, and since neither the CT11MP nor its corresponding FPGA
> (AN152) mention any alternate routing direct to the Core Tile GIC, I'd guess
> it probably still is. On the other hand, though, it also says this:
>
>   "... However this interrupt signal is reserved for future use and you
>    must use a polling routine instead of an interrupt service routine."
>
> So maybe it's appropriate to just remove the interrupt everywhere :/

Hm I don't think there will be future releases of these EB
boards anytime soon, so I suspect we could just add it.

But as it works fine without IRQ we can just leave it as well.

Yours,
Linus Walleij
