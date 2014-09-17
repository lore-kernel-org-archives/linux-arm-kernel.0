From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 17 Sep 2014 17:11:01 +0100
Subject: [PATCH 2/2] ARM: vexpress: Remove non-DT code
In-Reply-To: <20140917152735.GU12361@n2100.arm.linux.org.uk>
References: <1410359618-3441-1-git-send-email-pawel.moll@arm.com>
 <1410359618-3441-2-git-send-email-pawel.moll@arm.com>
 <20140910145818.GG12361@n2100.arm.linux.org.uk>
 <1410363657.23973.48.camel@hornet>
 <20140917152735.GU12361@n2100.arm.linux.org.uk>
Message-ID: <1410970261.30394.15.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-09-17 at 16:27 +0100, Russell King - ARM Linux wrote:
> On Wed, Sep 10, 2014 at 04:40:57PM +0100, Pawel Moll wrote:
> > On Wed, 2014-09-10 at 15:58 +0100, Russell King - ARM Linux wrote:
> > > So, I'll then be asking ARM to provide updated instructions on how to
> > > boot the CT9x4 with DT... 
> 
> Let me repeat: a boot loader with network booting capability is an
> absolute necessity for me.  This is *required* for unattended boots of
> kernels which have just been built.  If a platform doesn't have this
> capability, I'm just not interested in it, and I _will_ not use it.  It
> really is that simple.
> 
> My position on the boot loader issue is not going to change; it's a
> fundamental requirement for automatic build and boot testing, and for
> efficient workflow at other times.

I understand.

As Boot Monitor is not going to do TFTP in foreseeable future, the
"compat" approach of glueing zImage with dtb is a potential solution.

I've just tested a build with CONFIG_ARM_ATAG_DTB_COMPAT=y and
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y - after cat-ing
arch/arm/boot/zImage with arch/arm/boot/dts/vexpress-v2p-ca9.dtb
everything worked fine, booting with a root filesystem on a MMC card.

Of course I tried this with Boot Monitor, but I would hope that it will
work with uboot without any problem as well.

Pawel
