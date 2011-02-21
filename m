From: philippe.retornaz@epfl.ch (Philippe =?iso-8859-1?q?R=E9tornaz?=)
Date: Mon, 21 Feb 2011 21:25:45 +0100
Subject: dma_declare_coherent_memory() again.
In-Reply-To: <Pine.LNX.4.64.1102211602140.26977@axis700.grange>
References: <Pine.LNX.4.64.1102211602140.26977@axis700.grange>
Message-ID: <201102212125.45229.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le lundi, 21 f?vrier 2011 16.37:00, Guennadi Liakhovetski a ?crit :
> Hi All
> 
> AFAIU, dma_declare_coherent_memory() is still present on the following
> platforms:
> 
(...)
> arch/arm/mach-mx3/mach-mx31moboard.c
(...)
> and there are no pending patches to fix them for 2.6.38, is this right? If
> there are no realistic plans for proper memory reservation on ARM in
> 2.6.38, shall I just submit patches to disable those calls on the above
> platforms and hope, that the user manages to get RAM without boot-time
> reservation? Or is a definite failure preferred?

I won't have the time to patch this before 2.6.38, but I plan to rebase my 
tree in the next couple of months. So you can either break it or just remove 
the call but AFAIK in both case it won't work as you cannot allocate a such 
big buffer without special pool.

Thanks,

Philippe
