From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Fri, 2 Dec 2016 16:27:18 +0100
Subject: [PATCH] imx_v6_v7_defconfig: enable SPIDEV module
In-Reply-To: <CAOMZO5C8OH6obRn_8zh5HA9zoanRXUpoqk=vEBx+fW3wraNS6Q@mail.gmail.com>
References: <20161202145631.19292-1-gary.bisson@boundarydevices.com>
 <CAOMZO5C8OH6obRn_8zh5HA9zoanRXUpoqk=vEBx+fW3wraNS6Q@mail.gmail.com>
Message-ID: <20161202152718.o4xv2ru5r7xw7t5e@t450s.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Fri, Dec 02, 2016 at 01:18:42PM -0200, Fabio Estevam wrote:
> Hi Gary,
> 
> On Fri, Dec 2, 2016 at 12:56 PM, Gary Bisson
> <gary.bisson@boundarydevices.com> wrote:
> > Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> > ---
> > Hi,
> >
> > Seems that this configuration is missing, especially since many
> > device trees are already using "spidev" nodes.
> 
> Then they will trigger the following warning below (from the spidev
> probe function):
> 
> /*
> * spidev should never be referenced in DT without a specific
> * compatible string, it is a Linux implementation thing
> * rather than a description of the hardware.
> */
> if (spi->dev.of_node && !of_match_device(spidev_dt_ids, &spi->dev)) {
>     dev_err(&spi->dev, "buggy DT: spidev listed directly in DT\n");
>     WARN_ON(spi->dev.of_node &&
>                        !of_match_device(spidev_dt_ids, &spi->dev));
> }

Yes I've seen this WARN_ON when doing the dt-overlay testing. But is
disabling the SPIDEV configuration a solution?

To be honest I disagree with that WARN_ON. Ok it means that the hardware
isn't fully described in the device tree but for development platforms
(such as ours or any rpi-like boards) the user can design his own
daugher board with whatever SPI device on it. Then using the spidev
interface is very convenient, so I don't understand what we are trying
to forbid here.

Regards,
Gary
