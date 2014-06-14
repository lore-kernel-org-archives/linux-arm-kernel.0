From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Jun 2014 23:36:29 +0200
Subject: [PATCH v2 2/3] mmc: Add APM X-Gene SoC SDHC controller support to
 Arasan SDHCI driver
In-Reply-To: <9432f705-fd6a-44a6-8e04-c0455f0a551c@BN1AFFO11FD054.protection.gbl>
References: <1401829985-5212-1-git-send-email-lho@apm.com>
 <1401829985-5212-3-git-send-email-lho@apm.com>
 <9432f705-fd6a-44a6-8e04-c0455f0a551c@BN1AFFO11FD054.protection.gbl>
Message-ID: <5219148.cLBgakF4fc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 June 2014 08:09:12 Michal Simek wrote:
> > +
> > +static void sdhci_arasn_xgene_xlat_addr(struct sdhci_arasan_data *data,
> > +                                    u64 dma_addr)
> > +{
> > +     #define AIM_AXI_HI_OFFSET       0x0000000c
> > +     #define  AIM_AXI_ADDRESS_HI_N_WR(src) \
> > +                                     (((u32) (src) << 20) & 0xfff00000)
> 
> ditto with indentation.
> 20 should be shift
> 0xfff00000 is mask.
> 
> Also you should take this opportunity and add function description
> in kernel doc to be exactly clear what this function is doing.

Actually this should just be configured in the dma-ranges property
I think. It's not the driver's business to do the dma translation.

	Arnd
