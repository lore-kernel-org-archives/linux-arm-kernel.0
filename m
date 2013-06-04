From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 04 Jun 2013 14:22:03 +0400
Subject: [PATCH v8 2/3] ARM: shmobile: r8a7778: add USB support
In-Reply-To: <87zjv64eg1.wl%kuninori.morimoto.gx@renesas.com>
References: <201306020206.47199.sergei.shtylyov@cogentembedded.com>
 <201306020210.37520.sergei.shtylyov@cogentembedded.com>
 <87bo7ooxc9.wl%kuninori.morimoto.gx@renesas.com>
 <51AC6C78.7020900@cogentembedded.com>
 <87zjv64eg1.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <51ADBFCB.8040206@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04-06-2013 9:45, Kuninori Morimoto wrote:

>>> The ohci/ehci resource will be  used vainly if platform doesn't have USB

>>      The platform device resources are never used vainly. And remember
>> that if PHY doesn't get registered, OHCI/EHCI won't get probed
>> successfully either -- mind the usb_power_on() platform method.

> ?
> Could you please teach me who/how/when free resource memory
> which was kmemdup'ed by platform_device_add_xxx()
> (and kmalloc'ed dma_mask) on platform_device_register_full() ??

    I don't think there's a need to free them. The EHCI/OHCI devices
are always there after all.

>>> ohci/ehci and phy should be registered in same time/function.

>>     I just copied your approach from the R8A7779 code.

> Ahh, yes, indeed

     Moreover, from our prior testing, I'm afraid registering USB PHY 
and EHCI/OHCI in one function wouldn't work. Unless maybe if it's done 
from the init_late() machine's method...

> Best regards
> ---
> Kuninori Morimoto

WBR, Sergei
