From: b-liu@ti.com (Bin Liu)
Date: Mon, 9 Oct 2017 11:03:43 -0500
Subject: [PATCH] usb: musb: Check for host-mode using is_host_active() on
 reset interrupt
In-Reply-To: <20170927103522.30202-1-net147@gmail.com>
References: <20170927103522.30202-1-net147@gmail.com>
Message-ID: <20171009160343.GC32614@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 27, 2017 at 08:35:22PM +1000, Jonathan Liu wrote:
> The sunxi musb has a bug where sometimes it will generate a babble
> error on device disconnect instead of a disconnect IRQ. When this
> happens the musb controller switches from host mode to device mode
> (it clears MUSB_DEVCTL_HM/MUSB_DEVCTL_SESSION and sets
> MUSB_DEVCTL_BDEVICE) and gets stuck in this state.
> 
> The babble error is misdetected as a bus reset because MUSB_DEVCTL_HM
> was cleared.
> 
> To fix this, use is_host_active() rather than (devctl & MUSB_DEVCTL_HM)
> to detect babble error so that sunxi musb babble recovery can handle it
> by restoring the mode. This information is provided by the driver logic
> and does not rely on register contents.
> 
> Cc: stable at vger.kernel.org # v4.1+
> Signed-off-by: Jonathan Liu <net147@gmail.com>

Applied. Thanks.
-Bin.
