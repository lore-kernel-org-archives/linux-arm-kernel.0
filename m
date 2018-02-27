From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Tue, 27 Feb 2018 14:31:36 +0000
Subject: [PATCH] mmc: sdhci-of-arasan: Add quirk to avoid erroneous msg
In-Reply-To: <b35a8ac6-af47-5851-95ae-371288bb5f25@rock-chips.com>
References: <1519739731-27920-1-git-send-email-phil.edworthy@renesas.com>
 <b35a8ac6-af47-5851-95ae-371288bb5f25@rock-chips.com>
Message-ID: <HK2PR0601MB1393B39958A128DCB8CA0E44F5C00@HK2PR0601MB1393.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 27 February 2018 14:28, Shawn Lin wrote:
> ? 2018/2/27 21:55, Phil Edworthy ??:
> > Since the controller does not support the end-of-busy IRQ, don't use it.
> > Otherwise, on older SD cards you will get lots of these messages:
> > "mmc0: Got data interrupt 0x00000002 even though no data operation was
> in progress"
> >
> 
> I'm afraid you have to explain which version of arasan's IP suffer from this
> and what does the "older SD cards" mean?
Ok, I'll try to find out the IP version...
For "older SD cards", I can provide a list of a few cards that exhibit this problem
and others that don't, is that enough info?

Thanks
Phil

> > This has been reported on Xilinx devices that also use the Arasan IP.
> > See https://patchwork.kernel.org/patch/8062871/
> >
> > This has been tested on the Renesas RZ/ND-DB board with the RZ/N1 SoC.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> >   drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-arasan.c
> > b/drivers/mmc/host/sdhci-of-arasan.c
> > index c33a5f7..ab66e32 100644
> > --- a/drivers/mmc/host/sdhci-of-arasan.c
> > +++ b/drivers/mmc/host/sdhci-of-arasan.c
> > @@ -290,7 +290,8 @@ static const struct sdhci_pltfm_data
> sdhci_arasan_pdata = {
> >   	.ops = &sdhci_arasan_ops,
> >   	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> >   	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> > -			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> > +			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> > +			SDHCI_QUIRK2_STOP_WITH_TC,
> >   };
> >
> >   static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32
> > intmask)
> >
> 
> 
> --
> Best Regards
> Shawn Lin
