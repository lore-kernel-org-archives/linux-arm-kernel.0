From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Aug 2015 14:32:48 +0200
Subject: [PATCH 0/2] drivers: PL061: Add platform driver probing support
In-Reply-To: <20150803094923.GI7557@n2100.arm.linux.org.uk>
References: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
 <20150803075848.GH7557@n2100.arm.linux.org.uk>
 <55BF33AD.5040502@huawei.com>
 <20150803094923.GI7557@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdbDduYxcubVKAuqdmwnw6d6R8bvQfYa0uRRYCF_Q6+MyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 3, 2015 at 11:49 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Aug 03, 2015 at 05:26:05PM +0800, Shannon Zhao wrote:

>> Oh, sorry. The changes for DT are not necessary. But for ACPI I think it
>> needs to convert pl061 to platform device since ACPI doesn't support
>> AMBA devices. The Pl011 also does the same thing to support ACPI
>> probing. See drivers/tty/serial/amba-pl011.c
>
> Maybe rather than having every AMBA driver also converted to a platform
> driver (which GregKH hates) maybe ACPI should support the AMBA bus
> instead?

I agree with Russell, and overall I'm not sure I'm very happy with
commit 0dd1e247fd39aed20fd2baacc62ca44d82534798
"drivers: PL011: add support for the ARM SBSA generic UART"
either.

I can see how this works, but it adds a big chunk of overhead to
every driver that want to support both PrimeCell MMIO probing
and devicetree and ACPI.

Devicetree is spawning awesome AMBA devices for PrimeCells
in drivers/of/platform.c, so why can't ACPI do the same?

The AMBA bus is intelligent and very helpful with things like
runtime suspend/resume. It also supports reading the version
registers to autodetect device characteristics.

Yours,
Linus Walleij
