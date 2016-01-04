From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 4 Jan 2016 09:12:15 -0800
Subject: [PATCH v5 3/5] driver core: handle -EPROBE_DEFER from
 bus_type.match()
In-Reply-To: <20160104163100.GK19062@n2100.arm.linux.org.uk>
References: <1450868368-5650-1-git-send-email-m.szyprowski@samsung.com>
 <1450868368-5650-4-git-send-email-m.szyprowski@samsung.com>
 <20160104163100.GK19062@n2100.arm.linux.org.uk>
Message-ID: <20160104171215.GB25961@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 04:31:00PM +0000, Russell King - ARM Linux wrote:
> On Wed, Dec 23, 2015 at 11:59:26AM +0100, Marek Szyprowski wrote:
> > From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > 
> > Allow implementations of the match() callback in struct bus_type to
> > return errors and if it's -EPROBE_DEFER then queue the device for
> > deferred probing.
> > 
> > This is useful to buses such as AMBA in which devices are registered
> > before their matching information can be retrieved from the HW
> > (typically because a clock driver hasn't probed yet).
> > 
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > [changed if-else code structure, adjusted documentation to match the code,
> > extended comments]
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> This patch _really_ needs an ack from Greg before I can merge it.
> 
> DRIVER CORE, KOBJECTS, DEBUGFS, KERNFS AND SYSFS
> M:      Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.gitS:      Supported
> F:      Documentation/kobject.txt
> F:      drivers/base/
> 
> alternatively, the whole series should be taken by Greg, with my ack
> for the amba and ARM bits.
> 
> Given that Greg is unlikely to respond this close to the merge window
> (he's not responded to my messages about the amba-pl011 driver having
> been messed up by the wrong patch set being taken...) I think this has
> basically missed the 4.5 merge window.  Sorry.

I've been on vacation, so give me a week or so to catch up on
everything...

And yes, this missed the 4.5 merge window, that closed last week for my
trees.

thanks,

greg k-h
