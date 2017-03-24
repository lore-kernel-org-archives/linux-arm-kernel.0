From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 24 Mar 2017 08:59:56 +0100
Subject: [PATCH 06/15] ARM: dts: r8a779x: fix PCI bus dtc warnings
In-Reply-To: <20170324070614.GJ1319@verge.net.au>
References: <20170322020313.24338-1-robh@kernel.org>
 <20170322020313.24338-6-robh@kernel.org>
 <20170324070614.GJ1319@verge.net.au>
Message-ID: <CAMuHMdXLqsLMdjZrHnWhho50JOqQHuOMD3HUr2Skiujq8OPG-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Mar 24, 2017 at 8:06 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Mar 21, 2017 at 09:03:04PM -0500, Rob Herring wrote:
>> dtc recently added PCI bus checks. Fix these warnings.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: linux-renesas-soc at vger.kernel.org
>> ---
>> Sub-arch maintainers, please apply to your trees unless arm-soc wants
>> to take the whole lot.
>
> I would prefer to take these through my tree to reduce the chances of
> conflicts emerging later.
>
> Geert, are you happy with this patch and its changelog as-is?

I'd use something like:

---8<----------
The bogus 'device_type = "pci"' confuses dtc, causing lots of totally
unrelated warnings.  After fixing that, real warnings like

    arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_device_reg):
Node /pci at ee090000/usb@0,1 PCI unit address format error, expected
"1,0"

are left.  Correct the unit-adresses and reg properties of the subnodes
to fix these.
---------->8---

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
