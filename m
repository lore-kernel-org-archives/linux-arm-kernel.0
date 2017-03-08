From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 08 Mar 2017 14:06:00 +0200
Subject: [PATCH RESEND^2] usb: gadget: udc: atmel: fix debug output
In-Reply-To: <20170308080032.3848369-1-arnd@arndb.de>
References: <20170308080032.3848369-1-arnd@arndb.de>
Message-ID: <87efy80y8n.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
> The debug output now contains the wrong variable, as seen from the compiler
> warning:
>
> drivers/usb/gadget/udc/atmel_usba_udc.c: In function 'usba_ep_enable':
> drivers/usb/gadget/udc/atmel_usba_udc.c:632:550: error: 'ept_cfg' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   DBG(DBG_ERR, "%s: EPT_CFG = 0x%lx (maxpacket = %lu)\n",
>
> This changes the debug output the same way as the other code.
>
> Fixes: 741d2558bf0a ("usb: gadget: udc: atmel: Update endpoint allocation scheme")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
> Originally this broke on Feb 1 and I sent this fix,
> I resent it after it wasn't applied by Feb 22.
>
> This is now one of only two build regressions that made it into
> 4.11-rc1 that are still broken on linux-next. Please apply

heh, it's in my queue. Just gimme time, I have a day job that's 100%
dedicated to mainline ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170308/cec8d438/attachment.sig>
