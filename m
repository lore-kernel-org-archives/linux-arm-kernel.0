From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed, 01 Feb 2017 11:24:32 +0100
Subject: [RESENT PATCH] ARM: bcm2835: Add devicetree for the Raspberry
 Pi 3, for arm (32)
In-Reply-To: <878tpqki0k.fsf@eliezer.anholt.net>
References: <1484845444-4617-1-git-send-email-kraxel@redhat.com>
 <87fukcgsqp.fsf@eliezer.anholt.net> <878tpqki0k.fsf@eliezer.anholt.net>
Message-ID: <1485944672.1076.50.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> -	bcm2835-rpi-zero.dtb
> >> +	bcm2835-rpi-zero.dtb \
> >> +	../../../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb

> Unfortunately, I just remembered yesterday that one of the requirements
> is that we not use these sorts of ../../../ references in the DT tree.
> Instead we have to use symlinks -- see arch/arm64/boot/dts/broadcom/ for
> how we did the last round of this.

Yes, we did that with the *.dtsi include files.
Not fully sure this is a requirement for the Makefile too.

> I think just having links from
> arch/arm64/boot/dts/broadcom/bcm2837*.dts* to arch/arm/boot/dts/ would
> be the solution, then this Makefile could just reference
> bcm2837-rpi-3-b.dtb.

I suspect it is not that easy, last time I tried it didn't work.
Will try again though.

cheers,
  Gerd
