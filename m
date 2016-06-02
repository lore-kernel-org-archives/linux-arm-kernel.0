From: kraxel@redhat.com (Gerd Hoffmann)
Date: Thu, 02 Jun 2016 11:14:30 +0200
Subject: [PATCH 09/32] bcm2837-rpi-3-b.dts for 32bit arm
In-Reply-To: <3336185.FIBLI6ezsy@wuerfel>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <5616246.RRQ2rLjLud@wuerfel> <1464850565.24775.40.camel@redhat.com>
 <3336185.FIBLI6ezsy@wuerfel>
Message-ID: <1464858870.24775.65.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi,

> > Well, it just includes the arm64 version as-is, so we don't have
> > duplication.  I'm open to suggestions to how handle this better.  
> > 
> > Symbolic link?
> > 
> > Reference to ../../../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
> > directly in the Makefile?
> > 
> > I've seen arch/arm/boot/dts/Makefile uses globs on *.dts, so I suspect
> > the later wouldn't be that straight forward.
> 
> It's just weird that the arm64 file includes the .dtsi files from arch/arm/
> and is then again included back from another file there.
> 
> I can see two possible ways to handle this better:
> 
> - leave the complete set of bcm2837 files in arch/arm and then have one
>   reference from arch/arm64 per .dts that refers to just that file.

So basically do it the other way around.  Would be a bit less messy
indeed.

> - come up with a rule to also build the .dtb files in arch/arm64 when
>   we run 'make dtbs' for arch/arm and leave this file there. The argument
>   that one could use the same dtb with a 32-bit kernel should basically
>   hold true for any arm64 system, it's not specific to rpi-3 really.

Yes, in theory.  No, in practice.  As far I know the rpi3 is the only
64bit soc where a almost identical 32bit version exists, so running
32bit kernels on a 64bit processor actually happens in practice and I
expect this to continue.  If you want create sdcard images which run on
any rpi variant this is pretty much the only reasonable way to do it.

>   We don't normally test 32-bit kernels on 64-bit SoCs because 64-bit
>   kernels are more efficient in a number of ways, and I'm sure there
>   are bugs that prevent some systems from working (aside from how some
>   machines cannot work because they don't have RAM below 4GB), but if
>   this is now something that users are interested in, making it just
>   work seems nicer than having a couple of board specific hacks.

See above, I have my doubts that the user interest in this expands to
other boards.  So I'd tend to pick the first option.

cheers,
  Gerd
