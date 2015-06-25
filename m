From: Haikun.Wang@freescale.com (Wang Haikun)
Date: Thu, 25 Jun 2015 03:50:12 +0000
Subject: [PATCH v1] arm: configs: Add Freescale LS1021A defconfig
References: <1431951726-10992-1-git-send-email-haikun.wang@freescale.com>
 <6265444.OllNdeKdQh@wuerfel>
Message-ID: <BN1PR0301MB0612502F3D47D2033C80BC4BF8AE0@BN1PR0301MB0612.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/20/2015 11:36 PM, Arnd Bergmann wrote:
> On Monday 18 May 2015 20:22:06 Haikun Wang wrote:
>> Add Freescale LS1021A initial defconfig file.
>> Enable I2C, LPUART, eDMA, WDT default.
>> LS1021AQDS and LS1021ATWR boot successfully with patch.
>> Above IPs also been verified successfully.
>>
>> Signed-off-by: Haikun Wang <haikun.wang@freescale.com>
>>
>
> Can you explain why you need a separate defconfig, aside from imx_v6_v7_defconfig
> and multi_v7_defconfig? Please put a reason into the description above,
Hi Arnd,

I have verified that if we want to use multi_v7_defconfig to boot 
LS1021A up, we need add below configurations:
+CONFIG_THUMB2_KERNEL=y
+CONFIG_VMSPLIT_2G=y
+CONFIG_VFP=y.

If we add those to multi_v7_defconfig, it may destroy other platforms.

Best Regards
Wang Haikun
> as we normally try to have only one defconfig per machine directory.
>
> Does this machine require LPAE to function correctly?
>
> 	Arnd
>
