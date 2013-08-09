From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 10 Aug 2013 00:50:15 +0200
Subject: [PATCH 00/20] ARM: pxa: move core and drivers to dmaengine
In-Reply-To: <1375889649-14638-1-git-send-email-zonque@gmail.com> (Daniel
 Mack's message of "Wed, 7 Aug 2013 17:33:49 +0200")
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
Message-ID: <87zjsqzdg8.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <zonque@gmail.com> writes:

>  * camera driver:
>      I started the transition, but I'm not sure how much sense that
>      makes without access to the hardware. I'd much appreciate if
>      anyone could volunteer for this piece; I'll happily share what
>      I got so far. Sascha, Sachin, Guennadi?
Hi Daniel,

Do you mean this driver ? :
drivers/media/platform/soc_camera/pxa_camera.c

In that case I might help. But before I can do that, I have to be convinced that
dmaengine can deal with this driver. I'm thinking in particular of :
 - "hot running DMA" queuing
 - multiple DMA channel synchronization (ie. 3 channel sync)

All that is described in there :
  Documentation/video4linux/pxa_camera.txt

If someone with dmaengine knowledge could have a look at pxa_camera.txt (maybe
Vinod ?) and tell me that dma_engine framework fullfills the 2 requirements,
then I'll be happy to help.

One minor point though is that I'm working on pxa27x. If the serie is not
compatible in a way with pxa27x, I won't be able to do anything.

Another point I'd like to know, is what is the performance penalty in using
dmaengine, and do you have any figures ?

Lastly, they was debug information to debug descriptors chaining, channel
statuses, requestors. I didn't see where these had gone, could you point me to
the right file ?

Cheers.

-- 
Robert
