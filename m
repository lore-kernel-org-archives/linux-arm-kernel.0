From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 4 Jan 2018 18:02:38 +0100
Subject: v4.14.9 on ARMv5: OK with gcc 4.8/5.4, NOK with gcc 7.2
Message-ID: <20180104180238.581b202c@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm pretty sure it has already been reported, but just in case: I'm
testing v4.14.9 on an ARMv5 platform (Kirkwood-based OpenBlocks A7).
mvebu_v5_defconfig boots fine when built with gcc 4.8 (good old
Sourcery toolchain) or gcc 5.4 (some old Linaro toolchain), but doesn't
boot at all when built with gcc 7.2 (Fedora toolchain). Even when
configured and booted with earlyprintk, the kernel doesn't say anything.

The toolchain being used is the default ARM toolchain provided by
Fedora 27. It says:

gcc version 7.2.1 20170915 (Red Hat Cross 7.2.1-1) (GCC)
GNU ld version 2.29.1-1.fc27

So it's quite bleeding edge.

Let me know if this has already been fixed, or if I should test a
patch. I have not tested 4.15-rc or next at this point, assuming that
if a fix had been made, it would have been backported to 4.14-stable.

Best regards,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
