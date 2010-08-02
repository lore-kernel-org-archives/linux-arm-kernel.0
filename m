From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Mon, 02 Aug 2010 11:39:39 +0200
Subject: [PATCH RFC] usb gadget: introduce usb_gadget_probe_driver
In-Reply-To: <1280501361-13410-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1280501361-13410-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <op.vgs04dub7p4s8u@pikus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Jul 2010 16:49:14 +0200, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> by using usb_gadget_probe_driver with driver->bind = NULL.  When all
> drivers are fixed to use the new function the bind member of struct
> usb_gadget_driver can go away.

On second thought, would it be hard to just fix all the gadgets?  It's not like there
are thousands of them so it shouldn't take that long.  Moreover, since you'd remove
the bind field and change the prototype of the usb_gadget_register() all instances
would be found at compile time.

With that and the other functions which use bind callbacks (usb_add_configuration(),
usb_composite_register()) the patch would be much better in my opinion and also
much better then my approach with __ref.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
