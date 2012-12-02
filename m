From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 02 Dec 2012 17:50:37 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCAxLzJdIEFSTTogaXhwNHh4OiBNb3ZpbmcgdGhlIHRp?=
 =?UTF-8?B?bWVyIGZsYWdzIGNvbnRyb2wgaW4gaXhwNHh4X2lycV9hY2soKSBwcm9jZWR1?=
 =?UTF-8?B?cmU=?=
In-Reply-To: <20667.22941.433988.716964@pilspetsen.it.uu.se>
References: <1354435770-2719-1-git-send-email-shc_work@mail.ru>
 <201212020011.42105.arnd@arndb.de>
 <20667.22941.433988.716964@pilspetsen.it.uu.se>
Message-ID: <1354456237.324126069@f360.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Alexander Shiyan writes:
>  > Rather than modify the EOI flags directly in the timer interrupt,
>  > let's deal with these flags in the ixp4xx_irq_ack() procedure.
> 
> Why?
> 
> All I see is that you're removing simple unconditional code from two
> interrupt handlers and adding a large conditional to ixp4xx_irq_ack,
> which will slow down all interrupt acks.
> 
> So in what way is this an improvement?

This is a right place for do it. Now we can use these interrupts in any
drivers without patching last one for touching ACK.

---
