From: richardcochran@gmail.com (Richard Cochran)
Date: Sat, 15 Nov 2014 20:27:39 +0100
Subject: [PATCH v4 2/6] input: touchscreen: ti_am335x_tsc: Remove udelay
 in interrupt handler
In-Reply-To: <1415941651-28962-3-git-send-email-vigneshr@ti.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <1415941651-28962-3-git-send-email-vigneshr@ti.com>
Message-ID: <20141115192739.GA18766@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 10:37:27AM +0530, Vignesh R wrote:
> From: Brad Griffis <bgriffis@ti.com>
> 
> TSC interrupt handler had udelay to avoid reporting of false pen-up
> interrupt to user space. This patch implements workaround suggesting in
> Advisory 1.0.31 of silicon errata for am335x, thus eliminating udelay
> and touchscreen lag. This also improves performance of touchscreen and
> eliminates sudden jump of cursor at touch release.

I back ported this series onto v3.15.1 in order to try this out on a
custom, beaglebone-like board. With this series, the touch is really
broken. (I had fixed the pen up problem in a totally different way for
a customer, and so I wanted to try out your solution.)

I will try to port the board code to a more recent kernel to try your
series again. With which kernel version did you test your patches?

And which board?

Thanks,
Richard
