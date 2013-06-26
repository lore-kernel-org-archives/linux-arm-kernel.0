From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 26 Jun 2013 01:15:32 -0700 (PDT)
Subject: [RFC] ARM: shmobile: r8a7790: add thermal driver support
In-Reply-To: <1372232164-31285-1-git-send-email-horms+renesas@verge.net.au>
References: <1372232164-31285-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <87haglnv8j.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> You can get current thermal by
> > cat /sys/class/thermal/thermal_zone?/temp
> 
> Based on similar work for the r8a73a4 by Kuninori Morimoto.
> 
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/mach-shmobile/setup-r8a7790.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> This patch is based on renesas-next-20130620
> 
> 
> Hi Morimoto-san,
> 
> with this patch applied I see that the thermal driver is initialised,
> but there seems to be some problem:
> 
> # dmesg | grep thermal
> rcar_thermal rcar_thermal: thermal sensor was broken
> rcar_thermal rcar_thermal: 1 sensor proved
> 
> Furthermore I see a negative temperature reading.
> 
> # cat /sys/devices/virtual/thermal/thermal_zone0/temp  
> -65000
> 
> I am wondering if you have any insight into this.

Hmm...
Does your clock-r8a7790 has MSTP522 for thermal driver ?


Best regards
---
Kuninori Morimoto
