From: josh.coombs@gmail.com (Josh Coombs)
Date: Fri, 15 Jun 2012 08:40:48 -0400
Subject: Converting kirkwood-goflexnet to DTS
In-Reply-To: <20120615104140.24bf25f3@skate>
References: <20120614141706.GA6676@lunn.ch>
 <CAMW5UfaPLUt3mub-rpZGKYG5GzjMntvrCOwu-q3r-twm-AgD=g@mail.gmail.com>
 <CAMW5UfYwZkXzGbJTZ7tBr+eA5_+Jcri3FzsoaptXJV94j2okzw@mail.gmail.com>
 <20120615104140.24bf25f3@skate>
Message-ID: <CAMW5UfaxqBXSToFGxiPu0GWFAeBddT-_XH8-Xv0A9L=XhDy7BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas, Andrew,

You were both correct.  After one additional test failure last night
and a lot more reading I reached the same conclusion, I was foolishly
thinking .dtbs would be automatically appended to the kernel when
configured to support that method of including them.

What I did this morning:

make
make kirkwood-goflexnet.dtb
cat arch/arm/boot/kirkwood-goflexnet.dtb >> arch/arm/boot/zImage
make uImage

That resulted in: http://pastie.org/4092019

Boots, with some serious errors, doesn't seem to mount a FS and stops.
 Reducing my kernel arguments down to "console=ttyS0,115200
earlyprintk rootfs=/dev/sda1 rootdelay=10" I see the same errors, but
I also show the key hardware involved being detected, and the nand
partitioning looks correct.  My status LED goes solid green, so it
appears something is working right.  I'll dig into goflexnet_init next
to try and determine what is wrong in there.

Josh C
