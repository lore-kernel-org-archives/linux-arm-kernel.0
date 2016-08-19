From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Aug 2016 17:46:29 +0100
Subject: [PATCH] ARM: sa1100: clear reset status prior to reboot
In-Reply-To: <1471625122.822734676@f202.i.mail.ru>
References: <E1bamfG-0002WE-49@rmk-PC.armlinux.org.uk>
 <1471625122.822734676@f202.i.mail.ru>
Message-ID: <20160819164629.GV1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 07:45:22PM +0300, Alexander Shiyan wrote:
> >???????, 19 ??????? 2016, 19:29 +03:00 ?? Russell King <rmk+kernel@armlinux.org.uk>:
> >
> >Clear the current reset status prior to rebooting the platform.  This
> >adds the bit missing from 04fef228fb00 ("[ARM] pxa: introduce
> >reset_status and clear_reset_status for driver's usage").
> >
> >Signed-off-by: Russell King < rmk+kernel@armlinux.org.uk >
> >---
> ...
> >?static void assabet_lcd_backlight_power(int on)
> >?{
> >-if (on)
> >+if (on && 0)
> ...
> It looks like you did not remove the debugging code.

Well spotted, absolutely right.  Damn that 'git commit -a'

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
