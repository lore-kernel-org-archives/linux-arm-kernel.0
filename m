From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Tue, 5 Jan 2016 09:49:47 +0100
Subject: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
In-Reply-To: <20160105041356.GE12777@atomide.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <568662FC.9050206@gmail.com> <20160104170206.GC12777@atomide.com>
 <201601041834.56056@pali> <20160104174001.GD12777@atomide.com>
 <568AC0F9.2010304@gmail.com> <20160105041356.GE12777@atomide.com>
Message-ID: <20160105084947.GG22661@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 January 2016 20:13:56 Tony Lindgren wrote:
> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160104 10:59]:
> > Hi,
> > 
> > On  4.01.2016 19:40, Tony Lindgren wrote:
> > >>On Monday 04 January 2016 18:02:06 Tony Lindgren wrote:
> > >>>> >Care to boot with CONFIG_OMAP_GPMC_DEBUG=y and post the gpmc related
> > >>>> >dmesg output?
> > 
> > Here it is, including the pre-gpmc log, keep in mind this is with restored
> > HWMOD_INIT_NO_RESET flag so rootfs is functional and I can get dmesg output
> > from the syslog. Don't know if it is helpful :). Also, this device has
> > Numonyx onenand (HW rev. 2204), unlike most of the others which have Samsung
> > onenand (HW rev. 2101 etc), no idea if it is relevant.
> 
> Thanks. I got the problem reproduced here too.
> 
> [    1.915557] gpmc cs0 after gpmc_cs_set_timings:
> [    1.920410] cs0 GPMC_CS_CONFIG1: 0xfb001201
> 
> Looks like in the failing case the clock rates are not properly
> calculated in GPMC and GPMCFCLKDIVIDER is set wrong in
> GPMC_CS_CONFIG1. Need to look at it more to figure out what's the
> best way to fix this.
> 
> Regards,
> 
> Tony

Hm... Maybe this problem is in U-Boot too?

-- 
Pali Roh?r
pali.rohar at gmail.com
