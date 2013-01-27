From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 27 Jan 2013 09:46:10 -0500
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <51053761.1020009@gmail.com>
References: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
 <1359283223-23082-2-git-send-email-gmbnomis@gmail.com>
 <510506F9.3070500@gmail.com> <20130127110857.GA23687@schnuecks.de>
 <51053761.1020009@gmail.com>
Message-ID: <20130127144610.GW1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 03:19:13PM +0100, Sebastian Hesselbarth wrote:
> On 01/27/2013 12:08 PM, Simon Baatz wrote:
> >Hi Sebastian,
> >
> >On Sun, Jan 27, 2013 at 11:52:41AM +0100, Sebastian Hesselbarth wrote:
> >>Jason posted a patch set that makes mv643xx DT compatible. IMHO this
> >>patch is obsolete when we have DT support for mv643xx.
> >>kirkwood_ge00/01_init will not be called with DT support at all.
> >
> >I know. This is to fix a regression in 3.8 (which currently does not
> >boot with my "modularized" config).
> 
> Simon,
> 
> I _cannot_ confirm that gbe is loosing its MAC address on Dove. I will
> post a follow-up patch to Jason's cleanup patches that will also
> grab a clock for smi. With that patch insmod'ing/rmmod'ing mv643xx_eth
> does work just fine here on Dove.

I believe Simon's issue is that the mv643xx_eth driver is not loaded at
boot, it's clocks get gated, then when he loads the driver, there is no
mac address.  Is that correct Simon?  I don't think unloading the driver
after boot will trigger this regression.

thx,

Jason.
