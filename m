From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 24 Mar 2011 16:20:32 +0100
Subject: multiple definition of `show_mem'
Message-ID: <4D8B6140.4020300@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

current mainline (v2.6.38-7210-gb81a618) on ARM/mxs has the following build failure:

> lib/lib.a(show_mem.o): In function `show_mem':
> .../linux-2.6/lib/show_mem.c:67: multiple definition of `show_mem'
> arch/arm/mm/built-in.o:.../linux-2.6/arch/arm/mm/init.c:82: first defined here
> make: *** [vmlinux.o] Error 1

After reverting these patches the kernel compiles...

cbf978bfb12d7deca97d7333f65eda0381a072de oom: suppress nodes that are not allowed from meminfo on page alloc failure
29423e77c06cee7d4e335ef4a7cbd949da978c91 oom: suppress show_mem() for many nodes in irq context on page alloc failure
ddd588b5dd55f14320379961e47683db4e4c1d90 oom: suppress nodes that are not allowed from meminfo on oom kill

No time to boot the kernel, though.

cheers, MArc

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110324/9ffa1e92/attachment.sig>
