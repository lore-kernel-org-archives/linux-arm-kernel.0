From: mpe@ellerman.id.au (Michael Ellerman)
Date: Mon, 07 Aug 2017 17:18:12 +1000
Subject: [PATCH 3/3] powerpc: replace vga_fixup() with generic code
In-Reply-To: <20170804102033.27731-4-dja@axtens.net>
References: <20170804102033.27731-1-dja@axtens.net>
 <20170804102033.27731-4-dja@axtens.net>
Message-ID: <87efsnq217.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Axtens <dja@axtens.net> writes:

> Currently, we do a PCI fixup to mark a default card so that Xorg
> autoconfiguration works.
>
> There is a new generic method to do this sort of vga fixup, and
> it occurs by default.
>
> Drop our old method.
>
> This method is different:
>  - it will only mark a card as default if a driver is bound
>  - the marking will happen at late_initcall time, or even later
>    if a card is enabled later on (via an ENABLE hook). Currently
>    things are enabled in a FINAL hook.
>
> This *does* change behaviour under some circumstances.
>
> For example, pseries_le_defconfig doesn't have DRM drivers for
> many of the qemu GPU models, including the 'standard' vga.

Should we enable them/it?

cheers
