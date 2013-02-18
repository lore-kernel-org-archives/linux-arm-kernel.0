From: balbi@ti.com (Felipe Balbi)
Date: Mon, 18 Feb 2013 12:10:32 +0200
Subject: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from driver
In-Reply-To: <5121FCC8.7090604@ti.com>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
 <5121FCC8.7090604@ti.com>
Message-ID: <20130218101032.GA32688@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 18, 2013 at 03:34:56PM +0530, Santosh Shilimkar wrote:
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
> >Santosh Shilimkar (2):
> >   ARM: OMAP2+: hwmod-data: UART IP needs software control of sidle
> >     modes
> >   SERIAL: OMAP: Remove the idle handling from the driver
> >
> HWMOD_SWSUP_SIDLE flag will is not what will help UART completely.
> Also considering UART also needs async wakeup enabled as it implements
> another such hook and attaches that through function pointer.

this is exactly what I said at [1], which I quote:

"Also, $SUBJECT isn't improving the situation regarding UART Wakeup,
there is still the regression of UART never being wakeup capable.

I wonder what are your ideas to sort that part out, I mean, how do you
plan to implement ->set_wake() for the tty port ?"

> So some more work is needed to get that sorted out at least from
> sysc point of view. That way we can deal with io_ring stuff using
> pin control APIs.
> 
> Some patches will follow in attempt to address it. Stay tuned !!

good

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130218/e4de2d46/attachment.sig>
