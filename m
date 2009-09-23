From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 23 Sep 2009 21:24:34 +0200
Subject: [PATCH 1/5] s3c2410_udc: 2440 dual packet workaround
In-Reply-To: <200909231046.36330.anarsoul@gmail.com> (Vasily Khoruzhick's
	message of "Wed, 23 Sep 2009 10:46:30 +0300")
References: <200909231046.36330.anarsoul@gmail.com>
Message-ID: <87vdj9xy4t.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily Khoruzhick <anarsoul@gmail.com> writes:

> This needs to be examined further. For now, the patch seems to do the
> trick.
>
> Note that this is not a clean solution by any means, because we
> might potentially get stuck in that interrupt for quite a while.

Hi Vasily,

That workaround could also freeze the kernel if hardware fails, can't it ?

If there is no better patch found, Wouldn't this patch benefit at least a
counter to get out of the interrupt handler if the hardware doesn't behave at
the Nth loop ?

Cheers.

--
Robert
