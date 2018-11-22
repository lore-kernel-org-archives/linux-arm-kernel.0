From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Thu, 22 Nov 2018 05:19:31 +0000
Subject: [PATCH v3 0/7] spi: add support for octo mode
In-Reply-To: <468e7b5f-8840-2fce-2b47-325eeed577e4@ti.com>
References: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <468e7b5f-8840-2fce-2b47-325eeed577e4@ti.com>
Message-ID: <VI1PR04MB572680334F4BF09EDFAE3E7199DB0@VI1PR04MB5726.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vignesh,

> -----Original Message-----
> From: Vignesh R [mailto:vigneshr at ti.com]
> Sent: Tuesday, November 13, 2018 1:30 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> mtd at lists.infradead.org; boris.brezillon at bootlin.com; broonie at kernel.org;
> marek.vasut at gmail.com; linux-spi at vger.kernel.org;
> devicetree at vger.kernel.org
> Cc: robh at kernel.org; mark.rutland at arm.com; shawnguo at kernel.org; linux-
> arm-kernel at lists.infradead.org; computersforpeace at gmail.com;
> frieder.schrempf at exceet.de; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v3 0/7] spi: add support for octo mode
> 
> Hi Yogesh
> 
> On 23/10/18 3:07 PM, Yogesh Narayan Gaur wrote:
> > Add support for octo mode IO data transfer.
> > Micron flash, mt35xu512aba, supports octal mode data transfer and NXP
> > FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).
> >
> > Patch series
> > * Add support for octo mode flags and parsing of same in spi driver.
> > * Add parsing logic for spi-mem framework and m25p80.c device file.
> > * Add opcodes for octo I/O commands in spi-nor framework, Read and Write
> proto for (1-1-8/1-8-8) mode.
> >   Opcodes are added as per octal data IO commands required for
> mt35xu512aba [1] flash.
> > * Add mode bit required for octo mode in nxp-fspi driver [2].
> > * Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [2].
> >
> 
> You may have to rebase this series to avoid conflicts with recent spi.h changes.
Done, have send the next version with rebase on top of v4.20-rc2 [1] and resolving conflict with spi.h changes.
 
> Also, I suggest merging patches in [1] with this series if you plan to post another
> version so that all bits are at one place.
Patches for addition of the flash property has already been accepted.

--
Regards
Yogesh Gaur.

[1]   https://patchwork.ozlabs.org/project/linux-mtd/list/?series=77394

> 
> Regards
> Vignesh
> 
[...]
