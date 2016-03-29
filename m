From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 15:12:41 +0200
Subject: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
In-Reply-To: <1459248921.2565.15.camel@pengutronix.de>
References: <m3h9fuk7ik.fsf@t19.piap.pl> <m3shz9in52.fsf@t19.piap.pl>
 <1459248921.2565.15.camel@pengutronix.de>
Message-ID: <11848373.8j4FtIpEd5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2016 12:55:21 Lucas Stach wrote:
> Am Dienstag, den 29.03.2016, 12:39 +0200 schrieb Krzysztof Ha?asa:
> > Lucas Stach <l.stach@pengutronix.de> writes:
> > 
> > > Is this working with v4.4 and PCI_MSI enabled? I'm sure I've tested MSI
> > > IRQs before enabling them in the defconfig and they have been working
> > > for me for a long time before that. Tested with i210 on Gateworks
> > > Ventana.
> > 
> > MSI never worked for me on Ventana. I have been using 4.2 extensively,
> > and now I'm switching to 4.5 (which doesn't work either).
> > 
> > Could it be a DTS (bridge) problem(?)
> > 
> > On 4.5, trying to use it with TW6869 frame buffer and GW5410:
> > 
> > TW6869: PCI 0000:04:00.0, IRQ 336, MMIO 0x1100000
> > TW686x 0000:04:00.0: enabling device (0140 -> 0142)
> > 
> I don't see whee the device even tries to use MSI IRQs. Even if the
> infrastructure is enabled it opts to use legacy INTA.

It just never calls pci_enable_msi(), right? MSI is purely opt-in
for the driver, but it should just work if the device supports it
and you add that call.

	Arnd
