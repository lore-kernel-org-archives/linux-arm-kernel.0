From: horia.geanta@nxp.com (=?iso-8859-2?Q?Horia_Geant=E3?=)
Date: Tue, 6 Feb 2018 07:18:18 +0000
Subject: [PATCH v6 1/2] staging: fsl-mc: Move core bus out of staging
References: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
 <20180205140743.29974-2-bogdan.purcareata@nxp.com>
Message-ID: <VI1PR0402MB33427D7D04239420F3FE7D5A98FD0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/5/2018 4:08 PM, Bogdan Purcareata wrote:
> Move the source files out of staging into their final locations:
>   -mc.h include file in drivers/staging/fsl-mc/include go to include/linux/fsl
>   -source files in drivers/staging/fsl-mc/bus go to drivers/bus/fsl-mc
>   -overview.rst, providing an overview of DPAA2, goes to
>    Documentation/networking/dpaa2/overview.rst
[...]
>  rename {drivers/staging/fsl-mc => Documentation/networking/dpaa2}/overview.rst (100%)

Is this the proper location for documentation?
The doc focuses on networking, however there's also information about fsl mc
bus, dpio.

In the future, we might want to add doc for other dpaa2 objects sitting on the
fsl mc bus:
-dpseci ("Data Path SEC Interface" - abstraction for the crypto engine)
-dpdcei ("Data Path Decompression and Compression Engine Interface")

Would these fit under networking doc folder too?

Thanks,
Horia
