From: kraxel@redhat.com (Gerd Hoffmann)
Date: Thu, 02 Jun 2016 08:56:05 +0200
Subject: [PATCH 09/32] bcm2837-rpi-3-b.dts for 32bit arm
In-Reply-To: <5616246.RRQ2rLjLud@wuerfel>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <7065434.SNfT8zjcK3@wuerfel> <87zir4leyc.fsf@eliezer.anholt.net>
 <5616246.RRQ2rLjLud@wuerfel>
Message-ID: <1464850565.24775.40.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Do, 2016-06-02 at 00:39 +0200, Arnd Bergmann wrote:
> On Wednesday, June 1, 2016 3:30:35 PM CEST Eric Anholt wrote:
> > Arnd Bergmann <arnd@arndb.de> writes:
> > 
> > > On Wednesday, June 1, 2016 11:43:18 PM CEST Gerd Hoffmann wrote:
> > >> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> > >> new file mode 100644
> > >> index 0000000..36178a6
> > >> --- /dev/null
> > >> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> > >> @@ -0,0 +1 @@
> > >> +#include "../../../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts"
> > >> -- 
> > >> 1.8.3.1
> > >> 
> > >
> > > What does this gain you?
> > 
> > Many Raspberry Pi users use a small set of SD cards that they swap
> > between various versions of the hardware.  It would be good to have
> > their 32-bit OS images work on the Pi3 as well.
> 
> Sure, but you already have the dts file in the other directory,
> and the dtb is the same.
> 
> According to the comment in the other patch, the idea was to have
> the file in the arm64 directory because it's a 64-bit platform,
> but now you have it here as well.

Well, it just includes the arm64 version as-is, so we don't have
duplication.  I'm open to suggestions to how handle this better.  

Symbolic link?

Reference to ../../../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
directly in the Makefile?

I've seen arch/arm/boot/dts/Makefile uses globs on *.dts, so I suspect
the later wouldn't be that straight forward.

cheers,
  Gerd
