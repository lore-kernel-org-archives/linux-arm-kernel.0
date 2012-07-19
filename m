From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 19 Jul 2012 10:07:32 +0200
Subject: Devicetree: Initialization order of mmc block devices?
In-Reply-To: <5006D361.2070705@de.bosch.com>
References: <5006571A.7060103@de.bosch.com>
 <CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com>
 <50068696.8070408@de.bosch.com>
 <CAJe_Zhfmn4dUHk6xtudwCEurigvX64xce3VAozdjDdpSWSbRkA@mail.gmail.com>
 <5006C40D.300@de.bosch.com> <5006CE33.2040205@boundarydevices.com>
 <5006D361.2070705@de.bosch.com>
Message-ID: <20120719100732.0197abf9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 18 Jul 2012 17:16:49 +0200,
Knut Wohlrab <knut.wohlrab@de.bosch.com> a ?crit :

> No, because we have to know which will be the name of the root device 
> _before_ we start the kernel. In our embedded device we start the kernel 
> with a bootloader (U-Boot) and pass the root device with the kernel 
> command line parameter "root=/dev/mmcblk0p1". That is not possible if we 
> do not know what will be the name of the root device (mmcblk0 or 
> mmcblk1) when kernel try to mount it.

You can always work around this by having a minimal initramfs inside
your kernel, which contains a basic userspace environment that will
just locate the right location of the real root filesystem, mount it,
and switch to it. But I agree that it's a bit painful to have such a
complexity just to identify which device contains the root filesystem.

I also believe the root=UUID=... thing does not work when root= is
parsed by the kernel, unless you have a GPT partition table or
something like that. With the old-style partition table, the UUIDs are
inside the filesystems, and the kernel does not know about them. At
least that was my understanding of the matter about a year ago when I
looked into this.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
