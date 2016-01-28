From: horms@verge.net.au (Simon Horman)
Date: Thu, 28 Jan 2016 18:30:01 +0900
Subject: [PATCH/RFC] ARM: shmobile: r8a7794: Add thermal device to DT
In-Reply-To: <87si1i1d91.wl%kuninori.morimoto.gx@renesas.com>
References: <1453955575-32008-1-git-send-email-horms+renesas@verge.net.au>
 <87si1i1d91.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20160128093001.GA21863@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 05:35:07AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > as discussed briefly last week I am having some trouble enabling thermal
> > for the r8a7794/alt. With this patch applied on top of
> > renesas-devel-20160127-v4.5-rc1 I see:
> > 
> > # dmesg | grep thermal
> > [    1.089897] rcar_thermal e61f0000.thermal: thermal sensor was broken
> > [    1.101225] rcar_thermal: probe of e61f0000.thermal failed with error -22
> 
> Hmm... strange
> It can happen if thermal didn't work.
> It seems driver can't read data from register.
> 
> > I also see this with "[PATCH] thermal: core: don't call unsupported trip on
> > thermal_tripped_notify()" applied.
> 
> Oops, really ?
> I think you can't apply it on renesas-devel-20160127-v4.5-rc1

Yes, you are correct. What I did try was:

"[PATCH] thermal: of-thermal: return -EAGAIN until thermal_zone_of_sensor_register() was called"

> # I'm not sure why, but latest thermal branch, linus/master, linux-next/master
> # doesn't have problem patch 850ddee1144("thermal: improve hot trip handling")
> # So above patch is not needed
> 
> > IS this a kernel issue that you are aware of?
> > Is there a possibility that there is a problem with my hardware?
> 
> I think this is r8a7794 specific issue, but your patch looks sane for me...
> 
> > Any insight would be greatly appreciated.
> > 
> > AFIK this is not urgent.

[snip]
