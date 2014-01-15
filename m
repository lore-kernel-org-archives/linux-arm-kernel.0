From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Jan 2014 14:17:27 +0800
Subject: [PATCH v2 1/2] spi: spi-imx: enable dma support for escpi
 controller
In-Reply-To: <CAHrpEqT+9P_rRqaEd8O-FjR21=juF-NSTE8_umVJ83-6riO2_w@mail.gmail.com>
References: <1388789632-12238-1-git-send-email-Frank.Li@freescale.com>
 <20140114060254.GB1914@S2101-09.ap.freescale.net>
 <CAHrpEqT+9P_rRqaEd8O-FjR21=juF-NSTE8_umVJ83-6riO2_w@mail.gmail.com>
Message-ID: <20140115061725.GH1896@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 03:52:01PM -0600, Frank Li wrote:
> >> @@ -778,6 +1158,56 @@ spi_imx_unprepare_message(struct spi_master *master, struct spi_message *msg)
> >>       return 0;
> >>  }
> >>
> >> +static int spi_imx_sdma_init(struct spi_imx_data *spi_imx)
> >> +{
> >> +     struct dma_slave_config slave_config = {};
> >> +     struct device *dev = spi_imx->dev;
> >> +     int ret;
> >> +
> >> +
> >> +     /* Prepare for TX : */
> >> +     spi_imx->dma_chan_tx = dma_request_slave_channel(dev, "tx");
> >> +     if (!spi_imx->dma_chan_tx) {
> >> +             dev_err(dev, "cannot get the TX DMA channel!\n");
> >
> > So we will see this error message for each type of imx spi device,
> > though the driver only supports DMA for imx51-ecspi.
> >
> > Shawn
> 
> How to handle this one? change to devinfo? Or check check if imx51-ecspi?

I think we should check device type and only initialize DMA for
imx51-ecspi type of devices.

Shawn
