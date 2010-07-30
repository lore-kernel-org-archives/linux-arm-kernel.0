From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Fri, 30 Jul 2010 17:16:46 +0200
Subject: [PATCH RFC] usb gadget: introduce usb_gadget_probe_driver
In-Reply-To: <1280501361-13410-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1280501361-13410-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <op.vgnwp8107p4s8u@pikus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Jul 2010 16:49:14 +0200, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> This is like usb_gadget_register_driver with the only difference that it
> gets the bind function as parameter instead of using driver->bind.  This
> allows fixing section mismatches like
>
> 	WARNING: drivers/usb/gadget/g_printer.o(.data+0xc): Section mismatch in
> 	reference from the variable printer_driver to the function
> 	.init.text:printer_bind()
> 	The variable printer_driver references
> 	the function __init printer_bind()
>
> by using usb_gadget_probe_driver with driver->bind = NULL.  When all
> drivers are fixed to use the new function the bind member of struct
> usb_gadget_driver can go away.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Michal Nazarewicz <m.nazarewicz@samsung.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> ---
> Hello,
>
> there is an alternative patch in Greg's tree [1], but IMHO mine is
> better as it doesn't need __ref.
>
> Thoughts?

Personally I don't see advantage of this over changing the __init to __ref.
Or am I missing something?  I see your patch as an unnecessary API change.
The way I understand it, __ref was introduced exactly for cases like this
one where function is referenced from "normal" data but used only during
init.  Could you try to clarify for me why you think your solution is
better then mine?

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
