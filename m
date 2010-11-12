From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 12 Nov 2010 10:53:45 +0100
Subject: [PATCH v2] ARM: fix compile warning in mm/init.c
In-Reply-To: <1289552567-14005-1-git-send-email-gadiyar@ti.com>
References: <1289552567-14005-1-git-send-email-gadiyar@ti.com>
Message-ID: <20101112095345.GG18358@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Anand,

On Fri, Nov 12, 2010 at 02:32:47PM +0530, Anand Gadiyar wrote:
> Commit 7c63984b86 (ARM: do not define VMALLOC_END relative to PAGE_OFFSET)
> changed VMALLOC_END to be an explicit value. Before this, it was
> relative to PAGE_OFFSET and therefore automatically upgraded to
The correct term here is "converted".

> unsigned long as PAGE_OFFSET was an unsigned long. This introduced
s/was/is/

> the following build warning. Fix this by changing the explicit
> defines of VMALLOC_END to be unsigned long.
> 
>   CC      arch/arm/mm/init.o
> arch/arm/mm/init.c: In function 'mem_init':
> arch/arm/mm/init.c:606: warning: format '%08lx' expects type 'long unsigned int', but argument 12 has type 'unsigned int'
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
