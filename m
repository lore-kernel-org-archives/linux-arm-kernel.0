From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2016 10:19:33 +0100
Subject: [PATCH 1/2] ARM: sa1100: fix 3.6864MHz clock
In-Reply-To: <CALT56yNmjDuTO=zmQmUpKf3Ac4rNYZMEvMxBqmma=NB0H2YWwA@mail.gmail.com>
References: <E1baiKc-0004ya-J6@rmk-PC.armlinux.org.uk>
 <CALT56yNmjDuTO=zmQmUpKf3Ac4rNYZMEvMxBqmma=NB0H2YWwA@mail.gmail.com>
Message-ID: <20160823091933.GE1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 04:46:20AM +0300, Dmitry Eremin-Solenikov wrote:
> 2016-08-19 14:51 GMT+03:00 Russell King <rmk+kernel@armlinux.org.uk>:
> > pxa_timer wants to be able to call clk_enable() etc on this clock,
> > but our clk_enable() implementation expects non-NULL enable/disable
> > operations.  Provide these dummy implementations.
> 
> Acked-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Thanks.  Both patches should be in linux-next tonight.

(btw, this oops is another reason why OSTIMER0 could never have been
tested as working as intended - it's been working as not-intended.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
