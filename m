From: robh@kernel.org (Rob Herring)
Date: Fri, 29 Jul 2016 16:12:29 -0500
Subject: [PATCH V2 RFC 2/6] usb: dwc2: Add DT properties to specify fifo
 size in host/otg mode
In-Reply-To: <1469559213-16160-3-git-send-email-stefan.wahren@i2se.com>
References: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
 <1469559213-16160-3-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20160729211229.GA3575@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 06:53:29PM +0000, Stefan Wahren wrote:
> Currently the fifo sizes for host/otg mode are defined per platform
> and doesn't take the mode into account. So we will get errors
> like this:
> 
> dwc2 20980000.usb: 256 invalid for host_nperio_tx_fifo_size.
> dwc2 20980000.usb: Setting host_nperio_tx_fifo_size to 32
> 
> So add DT properties for these mode specific fifo sizes in order
> to define them in the devicetree and avoid these errors.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.txt |    3 +++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/usb/dwc2/core.c                        |   25 ++++++++++++++++++------
>  2 files changed, 22 insertions(+), 6 deletions(-)
