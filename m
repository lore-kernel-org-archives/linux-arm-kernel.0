From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed, 07 Sep 2016 12:59:16 +0200
Subject: [PATCH V3 RFT 3/5] ARM64: dts: bcm283x: Use dtsi for USB host mode
In-Reply-To: <bb073ea3-2f89-4fc5-e3af-2e27c54f221e@i2se.com>
References: <1471792204-21908-1-git-send-email-stefan.wahren@i2se.com>
 <1471792204-21908-4-git-send-email-stefan.wahren@i2se.com>
 <bb073ea3-2f89-4fc5-e3af-2e27c54f221e@i2se.com>
Message-ID: <1473245956.28663.50.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mi, 2016-08-31 at 09:59 +0200, Stefan Wahren wrote:
> Hi Gerd,
> 
> Am 21.08.2016 um 17:10 schrieb Stefan Wahren:
> > In case dr_mode isn't passed via DT, the dwc2 driver defaults
> > to OTG mode. But the Raspberry Pi 3 is designed only for host mode.
> > So fix this issue by linking to the dtsi file which set the dr_mode
> > to host.
> 
> this patch is pending and the rest has been merged. Since i don't have a
> RPi 3 it's only compile tested.
> 
> Could you please test it (requires patch 1 and 2 of this series) on your
> RPi 3?

Have a git tree to test?  Patch doesn't apply cleanly (using 4.8-rc5
with eric's for-next branch which already has 1+2), seems to depend on
more device tree changes.

Also usb is working fine for me on the rpi3 even without this, so why is
this needed?  Is dwc2 defaulting to otg mode a recent change?

cheers,
  Gerd
