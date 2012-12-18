From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 18 Dec 2012 15:19:02 +0100
Subject: [PATCH] arm: kirkwood: register DT devices earlier
In-Reply-To: <1355839667-1487-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1355839667-1487-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121218141902.GI3392@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 03:07:47PM +0100, Thomas Petazzoni wrote:
> The board-dt.c initialization functions calls the per-board legacy
> init functions (to probe devices that have not yet been converted to
> the Device Tree) before probing the devices declared in the Device
> Tree.
> 
> This unfortunately causes a boot crash on Topkick, because the
> board-specific initialization function sets a GPIO to some
> value. Unfortunately, since the devices declared in the Device Tree
> haven't been probed, the GPIO controllers haven't been probed, and the
> gpio_set_value() call causes the following crash:

Hi Thomas

I have a different fix for this.

The gpio is being used to supply power to SATA. So i turn it into a
fixed-regulator, using DT.

I will send the patch tonight.

  Andrew
