From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 29 Apr 2011 14:20:18 +0100
Subject: OMAP2+: UART: Remove uart clock handling code from serial.c
In-Reply-To: <1304080796-625-3-git-send-email-govindraj.raja@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-3-git-send-email-govindraj.raja@ti.com>
Message-ID: <20110429142018.165055b2@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Apr 2011 18:09:46 +0530
"Govindraj.R" <govindraj.raja@ti.com> wrote:

> Cleanup serial.c file in preparation to addition of runtime api's in omap-serial
> file. Remove all clock handling mechanism as this will be taken care with
> pm runtime api's in omap-serial.c file itself.
> 
> 1.) Remove omap-device enable and disable. We can can use get_sync/put_sync api's
> 2.) Remove context save/restore can be done with runtime_resume callback for
>     get_sync call. No need to save context as all reg details available in
>     uart_port structure can be used for restore, so add missing regs in
>     uart port struct.
> 3.) Add func to identify console uart.
> 4.) Erratum handling informed as flag to driver and func to handle erratum
>     can be moved to omap-serial driver itself.
> 
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

The tty parts of this look fine, the OMAP bits I have no idea.

So for the tty bits with my serial maintainer hat on

Acked-by: Alan Cox <alan@linux.intel.com>

but its mostly up to the ARM/OMAP people
