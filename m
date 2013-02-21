From: agnel.joel@gmail.com (Joel A Fernandes)
Date: Wed, 20 Feb 2013 19:37:10 -0600
Subject: [RFC] Kbuild support for ARM FIT images
Message-ID: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
I've been spinning some work-in-progress patches for FIT build support
in the kernel.
With the move to multiplatform support on OMAP, I feel it is a good
time to add  FIT support, also looking at the proliferating number of
dtbs, as it is a nice way

Currently the following is what I envision the way it will work:
- New "uImage-fit" target in $(boot)/ which is made to depend on "dtbs" target
- Changes to dtbs target to output a $(srctree)/.tmp_list_dtbs listing
the full paths to all the dtbs built
- A new script "mkfitsrc.sh" that spits out an ITS to
$(srctree)/.tmp_its . The above tmp file is passed
   - For each dtb, a new "device tree" node is created in the ITS
   - For each dtb, a new "configuration" node is created in the ITS
- mkimage is called on the ITS sources to output the kernel image.
(TODO: to use mkuboot.sh)

I have yet to do some boot time tests, as I don't have my board now
and don't want to post something that doesn't work. But all this has
been build-tested.

Any comments on this approach? Is it better to merge mkfitsrc.sh with
mkuboot.sh?

Regards,
Joel
