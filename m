From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 08 Aug 2012 11:50:49 -0600
Subject: Kernels on Bad Firmware (was Re: kernel entry for thumb2-only
 cpus)
In-Reply-To: <CAKGA1b=8gZdgpSJ28Hff+1199J0GarLxZU-NAv7JJDuk+La0ew@mail.gmail.com>
References: <CAKGA1b=8gZdgpSJ28Hff+1199J0GarLxZU-NAv7JJDuk+La0ew@mail.gmail.com>
Message-ID: <5022A6F9.2000206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2012 11:36 AM, Matt Sealey wrote:
...
> The fact we could update it with a script was the awesome thing about
> using OpenFirmware -
> but U-Boot can do this too, since libfdt is there and it's one option
> to enable it to allow script
> based modification of the blob. If the DT is hardcoded into the firmware somehow
> (CONFIG_OF_CONTROL I think) then platforms can load "boot.scr" from
> the root filesystem ...

Just a comment on CONFIG_OF_CONTROL...

In U-Boot, CONFIG_OF_CONTROL determines whether U-Boot uses a device
tree to configure itself. This is completely orthogonal to whether a
device tree is passed to the kernel, and where the kernel DT comes from,
which is still controlled by the bootm/bootz command parameters.

The DT used to configure U-Boot isn't the same one passed to the kernel
typically. The one for U-Boot is typically appended to the U-Boot image,
whereas the one passed to the kernel is likely loaded from a file in
/boot alongside the uImage/zImage of the kernel. I suppose the U-Boot
script /could/ be written to encode the location of the appended DTB
used by U-Boot and so pass the same one to the kernel, I don't believe
anyone has done that. Besides, U-Boot's copy of the .dts files has
diverged a little from the kernel's...:-(
