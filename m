From: balbi@ti.com (Felipe Balbi)
Date: Fri, 15 Feb 2013 15:07:45 +0200
Subject: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from driver
In-Reply-To: <511E323E.3050104@ti.com>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
 <511E323E.3050104@ti.com>
Message-ID: <20130215130745.GC16558@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 06:33:58PM +0530, a0131647 wrote:
> Hi,
> On Friday 15 February 2013 05:36 PM, Santosh Shilimkar wrote:
> >OMAP UART IP needs manual idle modes based on state of the
> >IP. Currently this is handled by the driver with function pointers
> >implemented in platform code.
> >
> >This however breaks in case of device tree because of missing
> >idle handling.
> >
> >The series tries to address the issue
> >
> >Patches has been tested on OMAP4 and OMAP5 devices where the console
> >slugishness was observed without idle mode handling. CPUIDLE and
> >suspend tested ok on these devices.
> >
> >Need help in testing on OMAP2, OMAP3 and AM3XXX devices.
> >
> Tested this series on omap3630 beagle board for:
> 1. Retention in idle and suspend.
> 2. Off mode in idle and suspend.
> 
> Tested-by: Sourav Poddar <sourav.poddar@ti.com>

try setting autosuspend_delay to -1

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130215/a6093ebf/attachment.sig>
