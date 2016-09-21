From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Sep 2016 21:29:22 +0200
Subject: [PATCH V3 3/4] ARM64 LPC: support serial based on low-pin-count
In-Reply-To: <815bebc1-96c9-2131-930d-bccdd4bf1c55@gmail.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <5525856.MfDSSsiP5d@wuerfel> <815bebc1-96c9-2131-930d-bccdd4bf1c55@gmail.com>
Message-ID: <4518414.hTLWuvFlBl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 21, 2016 6:12:28 PM CEST zhichang wrote:
> On 2016?09?15? 05:33, Arnd Bergmann wrote:
> > On Wednesday, September 14, 2016 11:04:33 PM CEST zhichang.yuan wrote:
> >> The 8250_hisi_lpc.c support both ACPI and dts similar to 8250_dw :
> >>
> >> +static struct platform_driver hs_lpc8250_driver = {
> >> +       .driver = {
> >> +               .name           = "hisi-lpc-uart",
> >> +               .of_match_table = hs8250_of_match,
> >> +               .acpi_match_table = ACPI_PTR(hs8250_acpi_match),
> >>
> >> So, I am a little confused why we need to support dts in 8250_of.c and support ACPI in another
> >> driver file.
> >>
> > 
> > After looking again, I'm pretty sure that drivers/tty/serial/8250/8250_pnp.c
> > will handle the ACPI case without modifications, you just need to adapt
> > the 8250_of driver to handle IORESOURCE_IO ports. This will be required
> > anyway with the next version once the LPC bridge is on the PCI bus.
> > 
> 
> Yes. You are right.
> 
> When the indirectIO patch is accepted, no much changes needed in these two file to support LPC UART.
> 
> BTW, what is your target to change these two files to support LPC uart?
> Do you think we don't need to add many new c files??

I think by modifying 8250_of.c, you should be able to make any UART on
some LPC bus work, regardless of what controller is used.

The ACPI version (8250_pnp.c) shouldn't need any changes at all if I
read that correctly.

	Arnd
