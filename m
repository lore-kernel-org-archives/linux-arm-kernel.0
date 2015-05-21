From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Thu, 21 May 2015 14:26:44 +0200
Subject: [PATCH v2] ARM: vexpress: Add unified-cache Device Tree property
In-Reply-To: <20150516201301.GT14416@pengutronix.de>
References: <5509437E.6060806@arm.com>
 <1426671298-2012-1-git-send-email-r.schwebel@pengutronix.de>
 <20150429191228.GO15254@pengutronix.de>
 <20150430110853.GN7440@e106497-lin.cambridge.arm.com>
 <20150430133011.GE15254@pengutronix.de> <55426A26.9060704@arm.com>
 <20150516201301.GT14416@pengutronix.de>
Message-ID: <20150521122644.GP14416@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sundeep,

On Sat, May 16, 2015 at 10:13:01PM +0200, Robert Schwebel wrote:
> On Thu, Apr 30, 2015 at 06:45:10PM +0100, Sudeep Holla wrote:
> > >I still see these errors with 4.1-rc1:
> > >
> > >[    0.000000] L2C: platform modifies aux control register: 0x02020000 -> 0x02420000
> > >[    0.000000] L2C: DT/platform modifies aux control register: 0x02020000 -> 0x02420000
> > >[    0.268626] platform 10000000.sysreg: Error -2 creating of_node link
> > >[    0.271997] platform basic-mmio-gpio.1.auto: Error -2 creating of_node link
> > >[    0.272266] platform basic-mmio-gpio.2.auto: Error -2 creating of_node link
> > >[    0.272681] platform basic-mmio-gpio.3.auto: Error -2 creating of_node link
> > 
> > OK, I was able to debug this, it boils down to initcall ordering.
> > Both of_init where the firmware sysfs is initialized and
> > vexpress_sysreg_init are at same core_initcall level. Needs some
> > thinking and more time to fix this.
> 
> Did you find out something in the meantime?
> I just tested 4.1-rc3 and the issues are still confirmed.

Gentle ping ...

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
