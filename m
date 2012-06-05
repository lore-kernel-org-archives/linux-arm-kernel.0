From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Jun 2012 13:08:34 +0200
Subject: [PATCH 2/2] ARM i.MX5: Hard reset the IPU during startup
In-Reply-To: <20429.57208.228315.164637@ipc1.ka-ro>
References: <1338888630-25930-1-git-send-email-s.hauer@pengutronix.de>
 <1338888630-25930-3-git-send-email-s.hauer@pengutronix.de>
 <20429.57208.228315.164637@ipc1.ka-ro>
Message-ID: <20120605110834.GQ30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 12:29:12PM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Sascha Hauer writes:
> >
> How would you implement a seamless transition from a boot logo to the
> application display when resetting the IPU during startup?

I usually say to Robert: Make the bootloader fast enough so that nobody
misses a splash from the bootloader. Robert is never happy with that
answer...

Is there any mainline compatible way to take over an initialized
graphics core? Usually we do not want to depend on preinitialized
hardware. With the graphics cores becoming more and more complex and
given that the DRM/KMS stuff is more complex than the framebuffer stuff
I'd first like to see a solution how this can be done in general before
I care about the specific implementations. When this is in place we can
easily remove the IPU reset (or only do it when we detect that the IPU
is uninitialized)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
