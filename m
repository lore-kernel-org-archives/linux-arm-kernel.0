From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 30 Apr 2016 09:38:16 +0100
Subject: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk
 numbering w/ device tree
In-Reply-To: <5723FCE3.9070308@hurleysoftware.com>
References: <CAD=FV=V9V8P=d59RX1eaAdVxJgMxub1F6hzQNw1QW+7t=3POBw@mail.gmail.com>
 <20160429215017.GC19428@n2100.arm.linux.org.uk>
 <CAD=FV=VgQX_EVhUUCugzv+CZqjzTS8LwyeU5419aX9FbDnWJDg@mail.gmail.com>
 <20160429221606.GE19428@n2100.arm.linux.org.uk>
 <CAD=FV=WzgGFzzpeYAPrOpMS684_G=XRoSRjTegK-vre=fX=kpw@mail.gmail.com>
 <20160429224407.GF19428@n2100.arm.linux.org.uk>
 <CAD=FV=U5jnJJ3v=nFGFecoKB5KGv1ufC+aKbHx2iCqBTWpDTww@mail.gmail.com>
 <5723F514.4@hurleysoftware.com>
 <CAD=FV=V_YyfBOSs7BLkyhv=_5HBmf3djUWACbL6d-bwnrueDjA@mail.gmail.com>
 <5723FCE3.9070308@hurleysoftware.com>
Message-ID: <20160430083816.GI19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 05:31:31PM -0700, Peter Hurley wrote:
> FWIW, there is already a defacto expectation by boot configurations in the
> field that a given mmc block device is stable across boots. The reality
> is that 100000's of kernel command lines look like:
> 
> 	root=/dev/mmcblk0p2

Thankfully, MMC does generally give a stable naming across reboots -
I have platforms with eMMC and SD (eg, the SDP4430 board which is in
the test farm) and only when things change in the kernel does the
MMC device name change.

Changes in device ordering can be provoked by the order in which
entries in the DT file appear, and hence the order in which the host
SD interfaces are probed by the kernel.

When it changed, I switched from using the device specifier to using
a UUID.  Now I have no problems since I no longer care which MMC
block device ends up as the SD card.

The kernel there is TFTP'd too.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
