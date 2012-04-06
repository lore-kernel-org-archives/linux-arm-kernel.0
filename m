From: b32955@freescale.com (Huang Shijie)
Date: Fri, 6 Apr 2012 10:45:07 +0800
Subject: Using GPMI-NAND driver on iMX28 using 3.4-rc1?
In-Reply-To: <20120406022305.GJ7264@S2101-09.ap.freescale.net>
References: <20120404070157.GB24930@pengutronix.de>
 <CAOdLEaqXyvHzTRSq2=RquZLqEO6kMEp11rjKJ+UtSqtF4nr-EA@mail.gmail.com>
 <20120404183314.GF17187@pengutronix.de>
 <CAOdLEaoboQowyx3T9ONjv-Y3q1JfFRb4ahS8CNrzeJi3N8Dczg@mail.gmail.com>
 <CAOMZO5AsbFDXHs3JRLC5=1MjZ7QrxciqV25xpZQL1Yvk3boQmw@mail.gmail.com>
 <CAOdLEaoEDr7fnswwV-Gs8tZF9Zj-RFnRa9Z=eqRFd0==OgV10Q@mail.gmail.com>
 <CAOMZO5AoFnM=cCR-kS4A1k2xY_bRd9+gN1p9bFxdyPS2-UdbkQ@mail.gmail.com>
 <4F7D3DB8.6080009@freescale.com>
 <CAOdLEaoy8ARS=awimR6fN8EcX+FrqxaSr3VUG3rP3zrNLOf+Gw@mail.gmail.com>
 <1333628861.31825.22.camel@vkoul-udesk3>
 <20120406022305.GJ7264@S2101-09.ap.freescale.net>
Message-ID: <4F7E58B3.4050408@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,
> Isn't it done in mxs_dma_tx_submit() already? The gpmi driver somehow
> misses the call to dmaengine_submit() for some case?
>
I checked the code again. It seems I do not miss the call to 
dmaengine_submit().

There are five places where call the dmaengine_submit() by 
start_dma_with_bch_irq()/start_dma_without_bch_irq():
         gpmi_send_command(),gpmi_send_data(),gpmi_read_data(), 
gpmi_send_page(), gpmi_read_page().

The gpmi nand code runs well in previous mxs-dma code.

BR
Huang Shijie
