From: horms@verge.net.au (Simon Horman)
Date: Wed, 26 Jun 2013 17:27:45 +0900
Subject: [RFC] ARM: shmobile: r8a7790: add thermal driver support
In-Reply-To: <87haglnv8j.wl%kuninori.morimoto.gx@renesas.com>
References: <1372232164-31285-1-git-send-email-horms+renesas@verge.net.au>
 <87haglnv8j.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20130626082743.GB1229@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 01:15:32AM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > You can get current thermal by
> > > cat /sys/class/thermal/thermal_zone?/temp
> > 
> > Based on similar work for the r8a73a4 by Kuninori Morimoto.
> > 
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/mach-shmobile/setup-r8a7790.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > This patch is based on renesas-next-20130620
> > 
> > 
> > Hi Morimoto-san,
> > 
> > with this patch applied I see that the thermal driver is initialised,
> > but there seems to be some problem:
> > 
> > # dmesg | grep thermal
> > rcar_thermal rcar_thermal: thermal sensor was broken
> > rcar_thermal rcar_thermal: 1 sensor proved
> > 
> > Furthermore I see a negative temperature reading.
> > 
> > # cat /sys/devices/virtual/thermal/thermal_zone0/temp  
> > -65000
> > 
> > I am wondering if you have any insight into this.
> 
> Hmm...
> Does your clock-r8a7790 has MSTP522 for thermal driver ?

No, thanks. I will fix that.
