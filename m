From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sat, 6 Apr 2013 23:10:42 +0200
Subject: PWM backlight build warning
In-Reply-To: <20130406200251.GO6597@opensource.wolfsonmicro.com>
References: <51606A7F.3050803@prisktech.co.nz>
 <20130406200251.GO6597@opensource.wolfsonmicro.com>
Message-ID: <20130406211041.GA15987@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 06, 2013 at 09:02:51PM +0100, Mark Brown wrote:
> On Sun, Apr 07, 2013 at 06:33:35AM +1200, Tony Prisk wrote:
> 
> > The problem occurs because when CONFIG_PM=y but CONFIG_PM_SLEEP=n:
> 
> > I guess this would be a problem on every driver that has been
> > converted to SIMPLE_DEV_PM_OPS.
> > I don't know enough about the PM code to offer a fix, or whethermy
> > chosen config is just 'invalid'.
> 
> You just need to put the system suspend functions inside an ifdef
> CONFIG_PM_SLEEP instead of CONFIG_PM.

I carry a fix for that in my for-next branch.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130406/9787f143/attachment.sig>
