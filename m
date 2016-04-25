From: dcb314@hotmail.com (David Binderman)
Date: Mon, 25 Apr 2016 20:26:22 +0000
Subject: linux-4.6-rc5/arch/arm/mach-pxa/pcm990-baseboard.c:354: possible
 missing code ?
Message-ID: <DUB128-W41502854DD81E8A089EBCA9C620@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there,

linux-4.6-rc5/arch/arm/mach-pxa/pcm990-baseboard.c:354]: (style) Variable 'val' is assigned a value that is never used.

Source code is

??? if ((1 << vdd) & p_d->ocr_mask)
??????? val |= PCM990_CTRL_MMC2PWR;
??? else
??????? val &= ~PCM990_CTRL_MMC2PWR;

??? pcm990_cpld_writeb(PCM990_CTRL_MMC2PWR, PCM990_CTRL_REG5);
??? return 0;

Suggest either use local variable val or delete it.


Regards

David Binderman
 		 	   		  
