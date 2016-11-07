From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 07 Nov 2016 11:34:43 +0100
Subject: imx6: PCIe imx6_pcie_assert_core_reset() hangs after watchdog
 reset
In-Reply-To: <CAOMZO5ADK9TvQiBs8HrKjNp+avZsO9xujZvG6CO2onZdAcDSGA@mail.gmail.com>
References: <1427377198.3378.16.camel@pengutronix.de>
 <20161106153117.GA22538@frolo.macqel>
 <CAOMZO5ADK9TvQiBs8HrKjNp+avZsO9xujZvG6CO2onZdAcDSGA@mail.gmail.com>
Message-ID: <1478514883.12872.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, den 06.11.2016, 14:59 -0200 schrieb Fabio Estevam:
> On Sun, Nov 6, 2016 at 1:31 PM, Philippe De Muyter <phdm@macq.eu> wrote:
> 
> > I use either v3.17 or Freescale's 4.1.15_1.2.0_ga
> 
> These kernel versions are not supported by the kernel community.
> 
> Do you observe issues with 4.8.6 or 4.9-rc4?

The problem is definitely present in current mainline Linux. I intent to
remove this workaround from the kernel, but we need to make sure that
the bootloader properly disables PCIe before jumping to the kernel
image.

I don't know what the status of this is in U-Boot, but Barebox already
does this correctly.

Fabio, would you mind to port this coed to U-Boot, or at least check if
it does the right thing?

Regards,
Lucas
