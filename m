From: rientjes@google.com (David Rientjes)
Date: Thu, 24 Mar 2011 15:22:50 -0700 (PDT)
Subject: multiple definition of `show_mem'
In-Reply-To: <4D8B6140.4020300@pengutronix.de>
References: <4D8B6140.4020300@pengutronix.de>
Message-ID: <alpine.DEB.2.00.1103241522230.26730@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Mar 2011, Marc Kleine-Budde wrote:

> Hello,
> 
> current mainline (v2.6.38-7210-gb81a618) on ARM/mxs has the following build failure:
> 
> > lib/lib.a(show_mem.o): In function `show_mem':
> > .../linux-2.6/lib/show_mem.c:67: multiple definition of `show_mem'
> > arch/arm/mm/built-in.o:.../linux-2.6/arch/arm/mm/init.c:82: first defined here
> > make: *** [vmlinux.o] Error 1
> 
> After reverting these patches the kernel compiles...
> 
> cbf978bfb12d7deca97d7333f65eda0381a072de oom: suppress nodes that are not allowed from meminfo on page alloc failure
> 29423e77c06cee7d4e335ef4a7cbd949da978c91 oom: suppress show_mem() for many nodes in irq context on page alloc failure
> ddd588b5dd55f14320379961e47683db4e4c1d90 oom: suppress nodes that are not allowed from meminfo on oom kill
> 
> No time to boot the kernel, though.
> 

Sorry about that, Marc.  I have a patch at

	http://marc.info/?l=linux-kernel&m=130100511521954

which should fix the issue for you (and I tested it with my arm cross 
compiler).
