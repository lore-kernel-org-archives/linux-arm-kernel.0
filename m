From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Fri, 15 Jan 2016 20:03:39 +0200
Subject: mvsdio not working on OpenRD
In-Reply-To: <20160110153843.GA22229@lunn.ch>
References: <20160110042619.GA22738@jirafa.cyrius.com>
 <20160110153843.GA22229@lunn.ch>
Message-ID: <20160115180339.GC18908@darkstar.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jan 10, 2016 at 04:38:43PM +0100, Andrew Lunn wrote:
> If i remember correctly, the OpenRD has some odd muxing going on with
> MMC and the second serial port. This fits the error message:
> 
>                         pmx_uart1: pmx-uart1 {
>                                 marvell,pins = "mpp13", "mpp14";
>                                 marvell,function = "uart1";
>                         };
> 
> and
> 
>                         pmx_sdio: pmx-sdio {
>                                 marvell,pins = "mpp12", "mpp13", "mpp14",
>                                                "mpp15", "mpp16", "mpp17";
>                                 marvell,function = "sdio";
> 			};
> 
> Either you can have MMC, or you can have the RS-232/RS485 on a DB9 or
> you can have MMC. You cannot have both.
> 
> It seems like older Debian kernels has defaulted to MMC, so we should
> probably disable the serial port.

In addition, the UART/SD selection GPIO needs to be set up. I sent a
patch proposal for this:

	http://marc.info/?l=linux-arm-kernel&m=145262936504783&w=2

> Please can you try the following patch. If this works, i can add it to
> mainline. The issue we might run into is that somebody else wants
> serial not MMC....

I use mainline kernel only, and I also think the default should be SD
like it used to be with legacy boot...

A.
