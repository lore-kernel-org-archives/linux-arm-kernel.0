From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 13 Jun 2018 18:08:36 +0200
Subject: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
In-Reply-To: <CAKv+Gu9+M8zOtACPQ4_UMgp-M1LfZnciYe1VTQNqn_zNWJea4g@mail.gmail.com>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <CGME20180613154552epcas5p4877f53310b66cf9d3e17196b0d028e41@epcas5p4.samsung.com>
 <CAKv+Gu9+M8zOtACPQ4_UMgp-M1LfZnciYe1VTQNqn_zNWJea4g@mail.gmail.com>
Message-ID: <6376822.ENUjdQ58sn@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 13, 2018 05:45:48 PM Ard Biesheuvel wrote:
> On 18 May 2018 at 16:17, Sinan Kaya <okaya@codeaurora.org> wrote:
> > A host bridge is allowed to remap BAR addresses using _TRA attribute in
> > _CRS windows.
> >
> > pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
> > pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
> >
> > When a VGA device is behind such a host bridge and the resource is
> > translated efifb driver is trying to do ioremap against bus address
> > rather than the resource address and is failing to probe.
> >
> > efifb: probing for efifb
> > efifb: cannot reserve video memory at 0x1e000000
> > efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
> > efifb: mode is 800x600x32, linelength=3200, pages=1
> > efifb: scrolling: redraw
> > efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> >
> > Use the host bridge offset information to convert bus address to
> > resource address in the fixup.
> >
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> Bartlomiej, could you please take these via the fbdev tree for v4.19?

Sure, I will queue it after the current merge window.

> Peter already gave his ack but Sinan dropped it (presumably because of
> the split in v2)

Peter, can I (re)add your ACK to V2 patches?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
