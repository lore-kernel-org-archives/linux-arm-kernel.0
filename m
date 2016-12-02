From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 2 Dec 2016 13:18:42 -0200
Subject: [PATCH] imx_v6_v7_defconfig: enable SPIDEV module
In-Reply-To: <20161202145631.19292-1-gary.bisson@boundarydevices.com>
References: <20161202145631.19292-1-gary.bisson@boundarydevices.com>
Message-ID: <CAOMZO5C8OH6obRn_8zh5HA9zoanRXUpoqk=vEBx+fW3wraNS6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gary,

On Fri, Dec 2, 2016 at 12:56 PM, Gary Bisson
<gary.bisson@boundarydevices.com> wrote:
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> ---
> Hi,
>
> Seems that this configuration is missing, especially since many
> device trees are already using "spidev" nodes.

Then they will trigger the following warning below (from the spidev
probe function):

/*
* spidev should never be referenced in DT without a specific
* compatible string, it is a Linux implementation thing
* rather than a description of the hardware.
*/
if (spi->dev.of_node && !of_match_device(spidev_dt_ids, &spi->dev)) {
    dev_err(&spi->dev, "buggy DT: spidev listed directly in DT\n");
    WARN_ON(spi->dev.of_node &&
                       !of_match_device(spidev_dt_ids, &spi->dev));
}
