From: clemens@ladisch.de (Clemens Ladisch)
Date: Tue, 09 Dec 2014 09:19:55 +0100
Subject: [alsa-devel] Question on arm64 unaligned faults during playback
In-Reply-To: <CAM4voam0h4e1Z8q3eqNpgMhhfw-zJpfh7fi4iznX_Y0bj98nKA@mail.gmail.com>
References: <CAM4voa=kiLsiLEzUbo3D+f1go5px78fXBSjSi7kGK4QCdnwPyQ@mail.gmail.com>	<54856621.8090107@ladisch.de>
 <s5hppbumnis.wl-tiwai@suse.de>	<54858868.70708@metafoo.de>	<20141208122549.GF16185@e104818-lin.cambridge.arm.com>
 <CAM4voam0h4e1Z8q3eqNpgMhhfw-zJpfh7fi4iznX_Y0bj98nKA@mail.gmail.com>
Message-ID: <5486B0AB.7000109@ladisch.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash Kesavan wrote:
> Currently, if I continue to use the SRAM allocation driver, two
> options are working:
> 1) ioremap to ioremap_wc in drivers/misc/sram.c.
> 2) copy_from_user to copy_from_user_toio in sound/core/pcm_lib.c
>
> Which would be the preferred option ?

I don't know how to tell the SRAM allocator to hand out WC memory, but
copy_from_user_toio() is what you would put into your .copy callback.


Regards,
Clemens
