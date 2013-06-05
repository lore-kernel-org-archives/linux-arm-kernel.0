From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Tue, 04 Jun 2013 17:17:56 -0700 (PDT)
Subject: [PATCH v8 2/3] ARM: shmobile: r8a7778: add USB support
In-Reply-To: <51ADBFCB.8040206@cogentembedded.com>
References: <201306020206.47199.sergei.shtylyov@cogentembedded.com>
 <201306020210.37520.sergei.shtylyov@cogentembedded.com>
 <87bo7ooxc9.wl%kuninori.morimoto.gx@renesas.com>
 <51AC6C78.7020900@cogentembedded.com>
 <87zjv64eg1.wl%kuninori.morimoto.gx@renesas.com>
 <51ADBFCB.8040206@cogentembedded.com>
Message-ID: <87ip1t5s2a.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

> > Could you please teach me who/how/when free resource memory
> > which was kmemdup'ed by platform_device_add_xxx()
> > (and kmalloc'ed dma_mask) on platform_device_register_full() ??
> 
>     I don't think there's a need to free them. The EHCI/OHCI devices
> are always there after all.

Yes, you are correct.
Many devices are existing in Renesas chip, not only EHCI/OHCI.

But in r8a7778 case, these ehci/ohci doesn't work if usb-phy wasn't enabled,
and without PFC settings from platform.


> >>     I just copied your approach from the R8A7779 code.
> 
> > Ahh, yes, indeed
> 
>      Moreover, from our prior testing, I'm afraid registering USB PHY 
> and EHCI/OHCI in one function wouldn't work. Unless maybe if it's done 
> from the init_late() machine's method...

I'm sorry.
This mention (= phy and ohci/ehci registration in one function) was my fault.
Your style is correct I think.

Best regards
---
Kuninori Morimoto
