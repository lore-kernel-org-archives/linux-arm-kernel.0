From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 29 Jan 2016 13:43:35 +0200
Subject: [PATCH] fbdev: mmp: print IRQ resource using %pR format string
In-Reply-To: <1453734191-1958245-1-git-send-email-arnd@arndb.de>
References: <1453734191-1958245-1-git-send-email-arnd@arndb.de>
Message-ID: <56AB5067.4010405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/01/16 17:03, Arnd Bergmann wrote:
> resource_size_t cannot be printed using the %x format string
> when we it is defined as u64:
> 
> drivers/video/fbdev/mmp/hw/mmp_ctrl.c: In function 'mmphw_probe':
> drivers/video/fbdev/mmp/hw/mmp_ctrl.c:506:22: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t {aka long long unsigned int}' [-Werror=format=]
>    dev_err(ctrl->dev, "%s: res %x - %x map failed\n", __func__,
>                       ^
> drivers/video/fbdev/mmp/hw/mmp_ctrl.c:506:22: error: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t {aka long long unsigned int}' [-Werror=format=]
> 
> This changes the format string to %pR, which is interpreted
> by the printk implementation to pretty-print a resource
> structure.

Thanks, queued for 4.5 fixes.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160129/d322aeb2/attachment-0001.sig>
