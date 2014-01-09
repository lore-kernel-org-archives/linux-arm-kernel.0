From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Thu, 09 Jan 2014 09:34:59 +0200
Subject: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
 <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
 <20140107235951.GH5074@atomide.com> <52CD5D13.9090806@ti.com>
 <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
Message-ID: <52CE5123.9050702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09.01.2014 07:06, Hiremath, Vaibhav wrote:
> Tomi,
>
> I am seeing underflow issue on AM43x device if I use omapfb_vram argument.
> Did you see this on OMAP?
>
> I am using "omapfb_vram=10M at 0xA0000000", and I believe it is correct way of usage.
>
> Thanks,
> Vaibhav
>

AFAIK underflow interrupts could come from badly calculated DSS core 
clock or bad HW resizer setup and should be unrelated to the memory 
allocation. It might be something similar to the problem I have on N900 
- see https://lkml.org/lkml/2014/1/6/173

Is it possible to upload the video you have problems with, so me to test 
it on N900? So far I didn't see any underflow issues on it (N900 is 
OMAP3, in case you're not aware), no matter the resolution of the videos 
I played(up to 720p), however I didn't test the part that allocates the 
memory on a pre-defined address. Though I don't think that should matter.

Ivo
