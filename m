From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 03 Nov 2014 08:32:57 +0100
Subject: [PATCH v2 0/4] Add support for pxa27x device-tree machine
In-Reply-To: <1830013.l3PUsHBfsL@wuerfel> (Arnd Bergmann's message of "Thu, 30
 Oct 2014 08:07:52 +0100")
References: <1413127731-1187-1-git-send-email-robert.jarzmik@free.fr>
 <87k33i6o7f.fsf@free.fr> <1830013.l3PUsHBfsL@wuerfel>
Message-ID: <87a94891sm.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thursday 30 October 2014 07:55:48 Robert Jarzmik wrote:
> Whole series
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
Thanks Arnd.

Unfortunately my checkers caught a flaw in the non-device tree case :
 - pxa27x_dt_init_irq() is defined, even if unused
 - it calls pxa_dt_irq_init(), which is conditionaly defined on CONFIG_OF
   => breaks non DT builds

So I'll have to enclose this function in a #if defined(CONFIG_OF), and respin
patch 1.

Cheers.

-- 
Robert
