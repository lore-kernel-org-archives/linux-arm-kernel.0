From: horia.geanta@nxp.com (Horia Geanta)
Date: Thu, 8 Nov 2018 11:23:07 +0000
Subject: [PATCH 7/9] arm64: defconfig: Drop CRYPTO_DEV_FSL_DPAA2_CAAM
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
 <e6e0105f-3135-e5b7-8224-419c9f730a09@free.fr>
 <85a73243-0c53-43e5-5002-90631c0a8c90@free.fr>
Message-ID: <VI1PR0402MB3485342DB8A0F5C5791E213798C50@VI1PR0402MB3485.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/7/2018 10:49 PM, Marc Gonzalez wrote:
> [ Add interested parties ]
> 
> On 07/11/2018 21:18, Marc Gonzalez wrote:
> 
>> Commit e8342cc7954e ("enable CAAM crypto engine on QorIQ DPAA2 SoCs")
>> enabled CRYPTO_DEV_FSL_DPAA2_CAAM, which depends on FSL_MC_DPIO,
>> which is not set.
>>
Thanks Marc.

Though I would prefer enabling the dependencies:
dpaa2-caam driver -> dpio driver (FSL_MC_DPIO) -> fsl-mc driver (FSL_MC_BUS).

Horia
