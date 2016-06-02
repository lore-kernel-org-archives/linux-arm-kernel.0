From: kraxel@redhat.com (Gerd Hoffmann)
Date: Thu, 02 Jun 2016 17:11:31 +0200
Subject: [PATCH 09/32] bcm2837-rpi-3-b.dts for 32bit arm
In-Reply-To: <4795604.XAe8xnhung@wuerfel>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <3336185.FIBLI6ezsy@wuerfel> <1464858870.24775.65.camel@redhat.com>
 <4795604.XAe8xnhung@wuerfel>
Message-ID: <1464880291.24775.111.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi,

> > > > Reference to ../../../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
> > > > directly in the Makefile?

Actually tried that, and to my surprise this worked fine for both "make
dtbs" and "make dtbs_install".

So we should just do that I guess ...

> > Yes, in theory.  No, in practice.  As far I know the rpi3 is the only
> > 64bit soc where a almost identical 32bit version exists, so running
> > 32bit kernels on a 64bit processor actually happens in practice and I
> > expect this to continue.  If you want create sdcard images which run on
> > any rpi variant this is pretty much the only reasonable way to do it.
> 
> I think the Allwinner A64 and the Samsung s5p6818 are other examples
> for this, where the initial run of boards all run 32-bit kernels
> for much of the same reasons. If users want to run a 32-bit distro
> on rpi-3 and on e.g. orange-pi, I don't see why they wouldn't also run
> the same binary on A64.

... and others can join the party on a case-by-case basis.

I still expect for the majority of arm64 boards it is not very useful,
so I don't think we should build all of them unconditionally.

cheers,
  Gerd
