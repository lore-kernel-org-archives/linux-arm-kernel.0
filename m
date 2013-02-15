From: balbi@ti.com (Felipe Balbi)
Date: Fri, 15 Feb 2013 15:08:42 +0200
Subject: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from driver
In-Reply-To: <20130215130745.GC16558@arwen.pp.htv.fi>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
 <511E323E.3050104@ti.com> <20130215130745.GC16558@arwen.pp.htv.fi>
Message-ID: <20130215130842.GD16558@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 03:07:45PM +0200, Felipe Balbi wrote:
> On Fri, Feb 15, 2013 at 06:33:58PM +0530, a0131647 wrote:
> > Hi,
> > On Friday 15 February 2013 05:36 PM, Santosh Shilimkar wrote:
> > >OMAP UART IP needs manual idle modes based on state of the
> > >IP. Currently this is handled by the driver with function pointers
> > >implemented in platform code.
> > >
> > >This however breaks in case of device tree because of missing
> > >idle handling.
> > >
> > >The series tries to address the issue
> > >
> > >Patches has been tested on OMAP4 and OMAP5 devices where the console
> > >slugishness was observed without idle mode handling. CPUIDLE and
> > >suspend tested ok on these devices.
> > >
> > >Need help in testing on OMAP2, OMAP3 and AM3XXX devices.
> > >
> > Tested this series on omap3630 beagle board for:
> > 1. Retention in idle and suspend.
> > 2. Off mode in idle and suspend.
> > 
> > Tested-by: Sourav Poddar <sourav.poddar@ti.com>
> 
> try setting autosuspend_delay to -1

Also try DT boot and try to wakeup from echo mem > /sys/power/state by
sending data through UART console.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130215/096d3ebe/attachment-0001.sig>
