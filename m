From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 Mar 2013 16:12:24 -0400
Subject: [PATCH] arm: mvebu: Fix the memory size on the Mirabox
In-Reply-To: <CABx3TkU9O9i2onVw3ntk4fZGaSct3i6GMmyL=H9j5e34Eyj-gQ@mail.gmail.com>
References: <1364579477-19018-1-git-send-email-ryan@presslab.us>
 <20130329180447.GK13280@titan.lakedaemon.net>
 <CABx3TkVK86b8Ku4EvUVe8OBtprwKW6YtJ7OU6YVHa3Bd5s7DsQ@mail.gmail.com>
 <20130329193716.GA7127@localhost>
 <20130329194453.GN13280@titan.lakedaemon.net>
 <CABx3TkWDrN1wCvECjja=EGeGFB-QpFmCG5FGO=1n+343fcCXcQ@mail.gmail.com>
 <20130330192030.GR13280@titan.lakedaemon.net>
 <CABx3TkU9O9i2onVw3ntk4fZGaSct3i6GMmyL=H9j5e34Eyj-gQ@mail.gmail.com>
Message-ID: <20130330201224.GT13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 30, 2013 at 12:40:33PM -0700, Ryan Press wrote:
> There really isn't streamlined support for appending a dtb to the
> kernel zImage.

$ cat my.dtb >>zImage
$ mkimage ...

which could be done in a pre-install hook in the deb, or as a kernel
post-install hook (eg running update-grub on a desktop).

> I have recently built and am testing a U-Boot that is working with
> devicetree, including the memory fixup.  If anyone wants to try it on
> their Mirabox, let me know.  So more work in the short term, but it
> eliminates the 'DOH! moments when I forget to install the special
> uImage and need to fart around in the bootloader.

mainline u-boot supports devicetree on ARM very well.  It might a better
use of time to add support for the Armada 370/XP to mainline
u-boot.

As an alternative, there is also barebox [1] which is more similar to
the kernel in layout, and has native Kconfig support.  It also needs
patches for Armada 370/XP, and kirkwood/dove/orion5x...

hth,

Jason.

[1] http://www.barebox.org
