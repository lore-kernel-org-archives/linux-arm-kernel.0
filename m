From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 6 Apr 2013 21:02:51 +0100
Subject: PWM backlight build warning
In-Reply-To: <51606A7F.3050803@prisktech.co.nz>
References: <51606A7F.3050803@prisktech.co.nz>
Message-ID: <20130406200251.GO6597@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 07, 2013 at 06:33:35AM +1200, Tony Prisk wrote:

> The problem occurs because when CONFIG_PM=y but CONFIG_PM_SLEEP=n:

> I guess this would be a problem on every driver that has been
> converted to SIMPLE_DEV_PM_OPS.
> I don't know enough about the PM code to offer a fix, or whethermy
> chosen config is just 'invalid'.

You just need to put the system suspend functions inside an ifdef
CONFIG_PM_SLEEP instead of CONFIG_PM.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130406/4475b2d3/attachment.sig>
