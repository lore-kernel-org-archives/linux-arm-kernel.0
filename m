From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 13 May 2014 21:45:52 -0600
Subject: [PATCH] ARM: tegra: enable console framebuffer rotation
In-Reply-To: <5372CE37.1080601@nvidia.com>
References: <1399432682-677-1-git-send-email-acourbot@nvidia.com>
 <536A57FA.2090608@wwwdotorg.org> <536AC45F.6080608@nvidia.com>
 <536CE414.5030406@suse.de> <536CF33A.3020906@wwwdotorg.org>
 <53727D9E.9050800@suse.de> <5372CE37.1080601@nvidia.com>
Message-ID: <5372E6F0.1050604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2014 08:00 PM, Alexandre Courbot wrote:
...
> Both SHIELD and TN7 come with a locked bootloader and cannot use U-boot.
> The bootloader can only boot a kernel from a dedicated, raw boot
> partition (Android style), can only pass a device tree from another raw
> "dtb" partition, and will fill it with plenty of dirty command-line
> options that make mainline unusable. That seems to be a lot for distros
> to handle, so at this stage we'd rather advise users to use a root FS
> image of their favorite distro along with a self-compiled kernel.

I don't know how much effort it's worth putting into this, but it
/might/ be possible to port U-Boot to the devices, and use that as the
"kernel" image that the binary bootloader boots, and then have U-Boot
boot a kernel from a filesystem in the "normal" way. That's kind what I
did by porting U-Boot to the Raspberry Pi. It would certainly increase
the possibility of a distro supporting these devices in a generic way,
as well as avoiding the need for hard-coded command-lines, memory
layout, etc. in the DT files. We'd have to make sure that any installer
didn't change the GPT layout, since then it'd get out of sync with the
tegrapt partitions, which could cause the bootloader to fail.
