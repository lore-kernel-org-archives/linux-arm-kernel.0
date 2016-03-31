From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 Mar 2016 10:17:10 +0200
Subject: [PATCH 2/6] mtd: physmap_of: add a hook for Versatile write
 protection
In-Reply-To: <CACRpkdZYTAyEejiVivhP44cEhxHMG6sL1VbrJjx=jGe-znyn7A@mail.gmail.com>
References: <1453806725-4880-1-git-send-email-linus.walleij@linaro.org>
 <1453806725-4880-3-git-send-email-linus.walleij@linaro.org>
 <CACRpkdY4fNfQWaKAZcak0yzJ2B17hbrqdU=Q4=NiwiWRNv_0yQ@mail.gmail.com>
 <CACRpkdZusueSh99D2JQj5=JQqHAeedTS=X2vm48U58PLbhamcQ@mail.gmail.com>
 <CACRpkdZYTAyEejiVivhP44cEhxHMG6sL1VbrJjx=jGe-znyn7A@mail.gmail.com>
Message-ID: <CACRpkdaxXqEhWV5xxF1H-ZYTZfqNdJh9xKTv+22YNYs68zwnRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 5, 2016 at 6:09 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Feb 22, 2016 at 8:09 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Sat, Feb 13, 2016 at 2:19 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Tue, Jan 26, 2016 at 12:12 PM, Linus Walleij
>>> <linus.walleij@linaro.org> wrote:
>>>
>>>> In order to support device tree probing of Versatile NOR flash
>>>> chips, there must be a way to add the VPP (write protection)
>>>> enable/disable callback. The register in question is in the
>>>> system controllers of these machines. Apart from this quirk,
>>>> the ARM flash chips are standard CFI flash chips from various
>>>> vendors.
>>>>
>>>> Additionally, the Integrator/AP require you to set up the external
>>>> bus interface (EBI) to allow writes to the chip select where the
>>>> flash memory is connected.
>>>>
>>>> Solve this by looking for the arm,versatile-flash compatible
>>>> string in the flash device tree node. In the driver,
>>>> add a special hook to check for the various Versatile syscons and
>>>> register a callback for .set_vpp() if this compatible is present.
>>>>
>>>> Provide a special Kconfig entry for the addon hook so it will
>>>> not be compiled in if the Versatile boards are not supported.
>>>> Stubs in the header file make sure the impact will be zero on
>>>> other platforms. (Compilers optimze this out.)
>>>>
>>>> With this patch, a large slew of ARM board file code can be
>>>> removed.
>>>>
>>>> Cc: Grant Likely <grant.likely@linaro.org>
>>>> Cc: Rob Herring <robh@kernel.org>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> Do you think my reply to this about reference counting and
>>> subsequent (accepted) patch to update the documentation
>>> to reflect 876fe76d793d03077
>>> "mtd: maps: physmap: Add reference counter to set_vpp()"
>>> is enough to warrant merging of this?
>>>
>>> If you want the code developed in any special direction
>>> just tell me.
>>
>> Ping.
>
> Ping.

Ping.

Yours,
Linus Walleij
