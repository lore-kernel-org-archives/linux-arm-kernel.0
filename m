From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 19 Oct 2010 12:05:41 +0200
Subject: [PATCH 1/5] Fix AT91SAM9G20 reset as per the errata in the data
	sheet
In-Reply-To: <20101015122902.GF11127@game.jcrosoft.org>
References: <20100528153725.GA5102@axolotl.localnet>
	<29a192a1f4f98dd05b72ed8eafe67bd6aadd8432.1287076894.git.nicolas.ferre@atmel.com>
	<20101015122902.GF11127@game.jcrosoft.org>
Message-ID: <4CBD6D75.4070908@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 15/10/2010 14:29, Jean-Christophe PLAGNIOL-VILLARD :
>> +at91sam9g20_reset:	mov	r0, #0
>> +			mcr	p15, 0, r0, c7, c5, 0	@ flush I-cache
> do we really need to flush the I-cache again

You are right, it is done in the calling function: arm_machine_restart().

I will correct it in the patch series.

Best regards,
-- 
Nicolas Ferre
