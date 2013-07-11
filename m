From: sr@denx.de (Stefan Roese)
Date: Thu, 11 Jul 2013 12:45:15 +0200
Subject: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
In-Reply-To: <51DE87D3.5030600@ti.com>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com>
 <51DC09E7.1070302@denx.de> <51DC164B.5010608@ti.com>
 <51DC1B47.7070504@denx.de> <51DE87D3.5030600@ti.com>
Message-ID: <51DE8CBB.4000709@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On 07/11/2013 12:24 PM, Roger Quadros wrote:
> Stefan,
> 
> I tried it out today and it worked 5/5 times. I used a bare bones
> debian root filesystem for
> the NFS root.

Thanks for testing.

> Could it be possible that the boot scripts on your filesystem are
> somehow shutting down
> the ethernet interface? Might be worth checking on a fresh filesystem.

I'm pretty sure that its not a problem with the filesystem. I'm using
exactly this filesystem for multiple other ARM based boards as well.
And all other boards (most of them with buildin ethernet controller
instead of USB connected) have no problem mounting/booting from it.

BTW: The filesystem is from the ELDK 5.3 [1][2]. You could download/install
it yourself.

>From your log I can see, that you are using a slightly different board
than I am ("Beagle xM Rev C" vs. "Beagle Rev C1/C2/C3"). So its a
different OMAP variant. Could this perhaps make a difference? Do you
by chance have the "old" Beagleboard (non-xM) at hand for another test?

Thanks again,
Stefan

[1] http://www.denx.de/wiki/view/ELDK-5/WebHome#Section_1.6.
[2] ftp://ftp.denx.de/pub/eldk/5.3/targets/armv7a/core-image-sato-sdk-generic-armv7a.tar.gz
