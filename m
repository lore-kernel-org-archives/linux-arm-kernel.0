From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 24 Aug 2017 15:18:43 +0300
Subject: [PATCH] ARM: OMAP2+: fix missing variable declaration
In-Reply-To: <12875092.dy1RW0XmqV@avalon>
References: <20170823132841.642239-1-arnd@arndb.de>
 <12875092.dy1RW0XmqV@avalon>
Message-ID: <02160c46-d0c1-dc49-2f4f-01d46d9f7723@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 23/08/17 16:53, Laurent Pinchart wrote:
> Hi Arnd,
> 
> On Wednesday, 23 August 2017 16:28:19 EEST Arnd Bergmann wrote:
>> The function that was added doesn't actually build:
>>
>> arch/arm/mach-omap2/display.c: In function 'omapdss_init_fbdev':
>> arch/arm/mach-omap2/display.c:184:2: error: 'r' undeclared (first use in
>> this function)
>>
>> This adds a declaration for 'r' to fix it.
>>
>> Fixes: 5ce783025c82 ("ARM: OMAP2+: Don't register omapdss device for
>> omapdrm")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Looks like I haven't tested the patch with CONFIG_FB_OMAP2 enabled after the 
> last rebase. I'm very sorry about that :-(
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Tomi, I assume you will pick this up and sent it to Dave for v4.14-rc1.

Yep, I'll pick it up. I could swear I tested omapfb build, but...
Obviously not.

 Tomi
