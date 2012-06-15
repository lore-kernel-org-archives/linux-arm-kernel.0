From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 15 Jun 2012 14:53:41 +0200
Subject: Converting kirkwood-goflexnet to DTS
In-Reply-To: <CAMW5UfaxqBXSToFGxiPu0GWFAeBddT-_XH8-Xv0A9L=XhDy7BQ@mail.gmail.com>
References: <20120614141706.GA6676@lunn.ch>
 <CAMW5UfaPLUt3mub-rpZGKYG5GzjMntvrCOwu-q3r-twm-AgD=g@mail.gmail.com>
 <CAMW5UfYwZkXzGbJTZ7tBr+eA5_+Jcri3FzsoaptXJV94j2okzw@mail.gmail.com>
 <20120615104140.24bf25f3@skate>
 <CAMW5UfaxqBXSToFGxiPu0GWFAeBddT-_XH8-Xv0A9L=XhDy7BQ@mail.gmail.com>
Message-ID: <20120615145341.1b40f84a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Josh,

Le Fri, 15 Jun 2012 08:40:48 -0400,
Josh Coombs <josh.coombs@gmail.com> a ?crit :

> You were both correct.  After one additional test failure last night
> and a lot more reading I reached the same conclusion, I was foolishly
> thinking .dtbs would be automatically appended to the kernel when
> configured to support that method of including them.

Yeah, but the DTB append feature is only a development/debugging
feature provided to allow DT-related development with non-DT capable
bootloaders. However, my understanding is that it is assumed that
people should ultimately use DT-capable bootloaders.

> That resulted in: http://pastie.org/4092019
> 
> Boots, with some serious errors, doesn't seem to mount a FS and stops.
>  Reducing my kernel arguments down to "console=ttyS0,115200
> earlyprintk rootfs=/dev/sda1 rootdelay=10" I see the same errors, but
> I also show the key hardware involved being detected, and the nand
> partitioning looks correct.  My status LED goes solid green, so it
> appears something is working right.  I'll dig into goflexnet_init next
> to try and determine what is wrong in there.

Haven't looked at the details, but aren't certain devices registered
multiple times?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
