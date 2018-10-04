From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu, 4 Oct 2018 11:10:30 +0200
Subject: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for mt35xu512aba
In-Reply-To: <VI1PR04MB103837831B8BFEC2F7FD12E799EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
 <20181003165603.2579-2-vigneshr@ti.com>
 <VI1PR04MB1038C20CA97E453FC4C9CEAE99EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181004093925.2961d881@bbrezillon>
 <VI1PR04MB103837831B8BFEC2F7FD12E799EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
Message-ID: <20181004111030.4ae3670c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Oct 2018 08:47:33 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> > 
> > Yogesh, you already sent "spi: add flags for octal I/O data
> > transfer" [3] which is only adding the new OCTAL flags but is not
> > patching spi.c and spi-mem.c to take those new flags into account.
> > Here is my version of this patch [2] (it's still missing an update
> > of SPI_MEM_MAX_BUSWIDTH). Let me know what you want to do (rework
> > your version to address the problem or take mine). 
> I haven't said that I have sent the patches.

Well, you at least sent one of them, I know it because I was in
CC :P.

> My patches are ready and needed to be sent for review.

I initially told you to drop those patches because we didn't have a
user yet, that's about to change, so I guess we're all good.

> In these patches,  I am adding support for X-X-X protocol for octal
> support and integrating them with spi  and flash m25p80 interface.

>From what I've seen you're not adding support of 8-8-8 but for 1-8-8 an
1-1-8, which is a lot easier to deal with (it's completely stateless,
which is what the spi-nor expects). Unless you're talking about other
patches you haven't sent yet...
