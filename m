From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Thu, 24 Mar 2011 18:46:22 +0530
Subject: [PATCH v3 1/7] mfd: add pruss mfd driver.
In-Reply-To: <4D776B05.4010506@pengutronix.de>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
	<1299592667-21367-2-git-send-email-subhasish@mistralsolutions.com>
	<4D776B05.4010506@pengutronix.de>
Message-ID: <384BC720F8C741B886DC000F067EBA20@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> A device may be de-initialized and another loaded or two different devices
> can be run simultaneously on the two cores.
> It's also possible, as in our case, to implement a single device on both
> the PRU's resulting in improved load sharing.

>Make you driver compile with sparse "make C=1", you cast way too much
>when accessing io mem. Use void __iomem * instead of u32 *.


With make C=1 I am receiving some warnings such as:

warning: cast removes address space of expression
drivers/mfd/da8xx_pru.c:61:17: warning: incorrect type in argument 1 
(different base types)
drivers/mfd/da8xx_pru.c:61:17:    expected void const volatile [noderef] 
<asn:2>*<noident>
drivers/mfd/da8xx_pru.c:61:17:    got int
drivers/mfd/da8xx_pru.c:66:28: warning: incorrect type in argument 1 
(different address spaces)

I can remove all of these by casting to (__force void  __iomem *) but is 
this correct.

-SG 
