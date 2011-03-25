From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 25 Mar 2011 12:06:56 +0100
Subject: multiple definition of `show_mem'
In-Reply-To: <alpine.DEB.2.00.1103241522230.26730@chino.kir.corp.google.com>
References: <4D8B6140.4020300@pengutronix.de>
	<alpine.DEB.2.00.1103241522230.26730@chino.kir.corp.google.com>
Message-ID: <4D8C7750.5070102@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2011 11:22 PM, David Rientjes wrote:
>> current mainline (v2.6.38-7210-gb81a618) on ARM/mxs has the following build failure:
>>
>>> lib/lib.a(show_mem.o): In function `show_mem':
>>> .../linux-2.6/lib/show_mem.c:67: multiple definition of `show_mem'
>>> arch/arm/mm/built-in.o:.../linux-2.6/arch/arm/mm/init.c:82: first defined here
>>> make: *** [vmlinux.o] Error 1

[..]

> Sorry about that, Marc.  I have a patch at
> 
> 	http://marc.info/?l=linux-kernel&m=130100511521954
> 
> which should fix the issue for you (and I tested it with my arm cross 
> compiler).

\o/ - the patch is already in mainline, boots like charm on my mx28evk.

regards, Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110325/d45f8f9a/attachment.sig>
