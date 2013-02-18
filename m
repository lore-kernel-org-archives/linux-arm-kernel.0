From: balbi@ti.com (Felipe Balbi)
Date: Mon, 18 Feb 2013 13:13:08 +0200
Subject: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from driver
In-Reply-To: <512208BE.7060207@ti.com>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
 <5121FCC8.7090604@ti.com> <20130218101032.GA32688@arwen.pp.htv.fi>
 <20130218101113.GB32688@arwen.pp.htv.fi> <5122019D.9030100@ti.com>
 <20130218104216.GC32688@arwen.pp.htv.fi>
 <20130218104541.GD32688@arwen.pp.htv.fi> <512208BE.7060207@ti.com>
Message-ID: <20130218111308.GE32688@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 18, 2013 at 04:25:58PM +0530, Santosh Shilimkar wrote:
> >>If I read the code correctly there's nothing setting oh->mux during DT
> >>boot. The only caller to omap_hwmod_mux_init() (which allocates and
> >>returns omap_hwmod_mux_info pointer) is
> >>arch/arm/mach-omap2/devices.c::omap4_keyboard_init(). This has nothing
> >
> >actually arch/arm/mach-omap2/serial.c::omap_serial_init_port() also
> >calls that, but it's also not used during DT boots.
> >
> DT boot, all the function pointers are broken so wakeup as well as slave
> idle-mode is broken. Nothing new here. Serial file does set the pads
> as you noticed and this is what can be offloaded to generic pint control
> which can triggered from driver.

fair enough, understood now.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130218/10c134e7/attachment.sig>
