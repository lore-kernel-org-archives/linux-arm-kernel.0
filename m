From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 20 Oct 2013 17:50:17 -0400
Subject: DreamPlug / GuruPlug support in 3.12-rc
In-Reply-To: <5264382E.9050207@gmail.com>
References: <5263C7C2.4000204@gmail.com>
 <20131020161747.GA15169@titan.lakedaemon.net>
 <5264382E.9050207@gmail.com>
Message-ID: <20131020215017.GD15169@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert,

Please don't toppost.  It makes it very frustrating for others in your
situation trying to solve their problem by reading the archives.

On Sun, Oct 20, 2013 at 09:08:14PM +0100, robert wrote:
> On 10/20/2013 05:17 PM, Jason Cooper wrote:
> > On Sun, Oct 20, 2013 at 01:08:34PM +0100, robert wrote:
...
> >> ffffffff        Marvell Kirkwood (Flattened Device Tree)
> >> Please check your kernel config and/or bootloader.
> > 
> > You need to enable CONFIG_ARM_APPENDED_DTB and then append the
> > appropriate dtb:

Did you do this?  It doesn't sound like you did.  Please attach the
console boot output.

> I've been running more tests, and still no luck, so far.

Can you cut-n-paste specific results?  eg configs, console output, etc?

> For 3.11, I found that selecting the 'Dreamplug' options for Kirkwood
> didn't work, and I had to select both 'Marvell GuruPlug Reference Board'
> _and_ 'Marvell GuruPlug Reference Board (Flattened Device Tree)', and
> then use kirkwood-guruplug-server-plus.dtb:

Your bootloader is, incorrectly, identifying itself as a Guruplug.  By
enabling 'Marvell GuruPlug Reference Board', the kernel executes that
legacy board file's machine_init.  It most likely isn't using the
appended dtb at all, but we can't say for certain until we see the boot
logs.

> # cat arch/arm/boot/zImage
> arch/arm/boot/dts/kirkwood-guruplug-server-plus.dtb >
> arch/arm/boot/zImage_w_dtb

Please don't do that.  Your board needs kirkwood-dreamplug.dtb,
otherwise it will enumerate a NAND flash that isn't there.


thx,

Jason.
