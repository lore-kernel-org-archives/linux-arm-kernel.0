From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Sep 2014 16:27:35 +0100
Subject: [PATCH 2/2] ARM: vexpress: Remove non-DT code
In-Reply-To: <1410363657.23973.48.camel@hornet>
References: <1410359618-3441-1-git-send-email-pawel.moll@arm.com>
 <1410359618-3441-2-git-send-email-pawel.moll@arm.com>
 <20140910145818.GG12361@n2100.arm.linux.org.uk>
 <1410363657.23973.48.camel@hornet>
Message-ID: <20140917152735.GU12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 04:40:57PM +0100, Pawel Moll wrote:
> On Wed, 2014-09-10 at 15:58 +0100, Russell King - ARM Linux wrote:
> > So, I'll then be asking ARM to provide updated instructions on how to
> > boot the CT9x4 with DT... 
> 
> The same version (although different build) of the Boot Monitor you have
> got for CA15_A7 (a.k.a. TC2) is able to boot CA9x4 with DT. It has got
> the same limitations though, namely no TFTP support, if this is your
> main concern (there is no ARM-provided uboot for TC2 either).

I don't use Boot Monitor.  I use uboot.  I use uboot because uboot supports
network booting.  I *require* networking booting.  Boot Monitor is a piece
of crap that no sane kernel developer would ever use as a boot environment.
I also boot a root filesystem off the MMC slot.

As for TC2, I just don't bother with that.  It's really not worth the
hastle.  I asked for help with that and got almost nothing.  Yes, there's
Nicolas' uboot, which solves some problems, but getting the kernel to
boot on TC2 turned out to be a dead loss - and no help with it was
forthcoming.  So I've permanently shelved the TC2 tile.  ARM Ltd can
have the TC2 tile back for all I care, it's more useful to me as a door
stop than something for running Linux.

Let me repeat: a boot loader with network booting capability is an
absolute necessity for me.  This is *required* for unattended boots of
kernels which have just been built.  If a platform doesn't have this
capability, I'm just not interested in it, and I _will_ not use it.  It
really is that simple.

My position on the boot loader issue is not going to change; it's a
fundamental requirement for automatic build and boot testing, and for
efficient workflow at other times.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
