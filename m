From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Apr 2012 11:45:48 +0800
Subject: Using GPMI-NAND driver on iMX28 using 3.4-rc1?
In-Reply-To: <4F7E58B3.4050408@freescale.com>
References: <20120404183314.GF17187@pengutronix.de>
 <CAOdLEaoboQowyx3T9ONjv-Y3q1JfFRb4ahS8CNrzeJi3N8Dczg@mail.gmail.com>
 <CAOMZO5AsbFDXHs3JRLC5=1MjZ7QrxciqV25xpZQL1Yvk3boQmw@mail.gmail.com>
 <CAOdLEaoEDr7fnswwV-Gs8tZF9Zj-RFnRa9Z=eqRFd0==OgV10Q@mail.gmail.com>
 <CAOMZO5AoFnM=cCR-kS4A1k2xY_bRd9+gN1p9bFxdyPS2-UdbkQ@mail.gmail.com>
 <4F7D3DB8.6080009@freescale.com>
 <CAOdLEaoy8ARS=awimR6fN8EcX+FrqxaSr3VUG3rP3zrNLOf+Gw@mail.gmail.com>
 <1333628861.31825.22.camel@vkoul-udesk3>
 <20120406022305.GJ7264@S2101-09.ap.freescale.net>
 <4F7E58B3.4050408@freescale.com>
Message-ID: <20120406034542.GM7264@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2012 at 10:45:07AM +0800, Huang Shijie wrote:
> hi,
> >Isn't it done in mxs_dma_tx_submit() already? The gpmi driver somehow
> >misses the call to dmaengine_submit() for some case?
> >
> I checked the code again. It seems I do not miss the call to
> dmaengine_submit().
> 
I do not have nand device to play.  Maybe you want to have a check
if dma_cookie_assign (dmaengine_submit) and dma_cookie_complete
(via mxs_dma_int_handler) are being called as a pair for gpmi.

-- 
Regards,
Shawn
