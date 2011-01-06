From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Jan 2011 09:42:37 +0000
Subject: [PATCH v2] i.MX51 Framebuffer support
In-Reply-To: <4D246C54.9060503@free.fr>
References: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>
	<4D246C54.9060503@free.fr>
Message-ID: <20110106094237.GB31708@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 02:04:20PM +0100, Julien Boibessot wrote:
> Hello,
> 
> Sascha Hauer a ?crit :
> > The following series adds i.MX51 framebuffer support based on the IPUv3. It
> > is not perfect but I decided it is good enough to open it for a wider audience
> > and collect first reviews. I tested this on a babbage board using both outputs
> > (VGA/DVI) with different resolutions up to 1680x1050 and different colour depths.
> > I also tested it on one custom board using a fixed display setting.
> >   
> This driver is also working fine for me on a custom i.MX51 board with a
> 800x480 18 bits TFT LCD (16bpp mode).
> 
> The only strange thing I noticed was a kind of uggly sprite/artefact
> (32x32, I would say) appearing at the same time as the Linux console. I
> think it may be related to a hardware cursor badly (?) initialised, but
> I didn't find a fix yet.
> It disappears when I launch a graphical application (Qt or SDL).

In the top left corner?  That'll be the linux penguin logo, and if it's
not coming out correctly, your framebuffer driver is badly broken.
Maybe your RGB bitfield information or visual is wrong?
