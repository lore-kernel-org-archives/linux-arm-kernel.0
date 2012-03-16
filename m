From: balbi@ti.com (Felipe Balbi)
Date: Fri, 16 Mar 2012 23:08:43 +0200
Subject: [PATCH 1/2] input: keypad: move platform_data to
 <linux/platform_data>
In-Reply-To: <1357514.ox9yZWgqO9@dtor-d630.eng.vmware.com>
References: <1331907989-11891-1-git-send-email-sourav.poddar@ti.com>
 <1331907989-11891-2-git-send-email-sourav.poddar@ti.com>
 <1357514.ox9yZWgqO9@dtor-d630.eng.vmware.com>
Message-ID: <20120316210841.GA19797@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 16, 2012 at 09:36:19AM -0700, Dmitry Torokhov wrote:
> On Friday, March 16, 2012 07:56:28 PM Sourav Poddar wrote:
> > From: Felipe Balbi <balbi@ti.com>
> > 
> > This patch allows us to drop the OMAP depencendy
> > from the OMAP4 keypad driver.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-4430sdp.c            |    1 +
> >  arch/arm/mach-omap2/devices.c                  |    1 +
> >  arch/arm/plat-omap/include/plat/omap4-keypad.h |    9 ---------
> >  drivers/input/keyboard/Kconfig                 |    1 -
> >  drivers/input/keyboard/omap4-keypad.c          |    2 +-
> >  include/linux/platform_data/omap4-keypad.h     |   13 +++++++++++++
> 
> Instead of creating platform_data directory why not move to
> include/linux/input/omap4-keypad.h?

look closer, that directory already exists. But if you prefer placing
that header on <linux/input> that's doable too.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120316/ffe20fa7/attachment-0001.sig>
