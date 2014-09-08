From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 08 Sep 2014 08:09:35 +0200
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <CAD=FV=UYDDhL02CrhPUAHPncepwAF2-BgTmXOamy-Mdz80S-vw@mail.gmail.com>
References: <20140905115704.GO13515@arm.com>	<20140905122232.GP13515@arm.com>	<CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>	<540C202E.2060009@collabora.co.uk>	<540C7F5B.6070307@gmail.com>
 <CAD=FV=UYDDhL02CrhPUAHPncepwAF2-BgTmXOamy-Mdz80S-vw@mail.gmail.com>
Message-ID: <540D481F.8030500@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 09/08/2014 06:36 AM, Doug Anderson wrote:
> 
> One (ugly?) solution would be to add a feature to your bootloader to
> modify the device tree to mark regulators as "always-on".  Since the
> booloader gets to touch the device tree and the bootloader is involved
> in communicating into about SimpleFB, it kinda makes sense.
> 

I can't say I like to mark the regulators as always-on on the DT and that's
why I copied the patch in the response instead of posting it as a proper patch
but I think relying in the bootloaders to modify the DT is not better.

IMHO U-boot should only modify the strictly necessary like the /chosen branch
even though lately I've seen some attempts in the OMAP community to (ab)use
U-Boot's fdt command to mangle the DT before passing to the kernel in order to
support different Beagle Bone Black capes.

Best regards,
Javier
