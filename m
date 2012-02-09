From: balbi@ti.com (Felipe Balbi)
Date: Thu, 9 Feb 2012 08:09:40 +0200
Subject: [PATCH] gpio: omap: be more aggressive with pm_runtime
In-Reply-To: <877gzwyivt.fsf@ti.com>
References: <1328707614-20146-1-git-send-email-balbi@ti.com>
 <877gzwyivt.fsf@ti.com>
Message-ID: <20120209060939.GB1121@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 08, 2012 at 04:01:42PM -0800, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
> 
> > try to keep gpio block suspended as much as possible.
> >
> > Tested with pandaboard and a sysfs exported gpio.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> 
> Looks like you need a few more get/puts around other places where
> registers are accessed.  It currently causes a boot crash on OMAP3 in
> _set_gpio_triggering().

it was a missing get/put on gpio_irq_set_type(). Fixed.

> Did you test GPIO wakeups?  both IO ring wakeups and GPIO module-level
> wakeups?

how can I test that easily with panda ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120209/fcca7d4e/attachment-0001.sig>
