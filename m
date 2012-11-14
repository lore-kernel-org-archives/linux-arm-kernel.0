From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 14 Nov 2012 11:08:49 +0100
Subject: [PATCH 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
In-Reply-To: <20121114070046.GE7407@opensource.wolfsonmicro.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-2-git-send-email-anilkumar@ti.com> <5097F078.50701@ti.com>
 <20121114022341.GM4415@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA6B043@DBDE01.ent.ti.com>
 <20121114062117.GC7407@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA6B0AF@DBDE01.ent.ti.com>
 <20121114070046.GE7407@opensource.wolfsonmicro.com>
Message-ID: <50A36DB1.3010706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 11/14/2012 08:00 AM, Mark Brown wrote:
> On Wed, Nov 14, 2012 at 06:49:58AM +0000, AnilKumar, Chimata wrote:
> 
>> Earlier you have a comment on this thread, I am adding my comments
>> on top of it. Sorry if I am in wrong direction.
> 
> Ah, I see.  I was just commenting because Benoit was asking if this
> should be supported with a standard framework feature - I'm not
> convinced that it should right now as there's not any clear patterns in
> hardware behaviour.  I've no specific interest in this system.

I was wondering that, because exposing a pin to control the whole PMIC
low power mode seems to be something that should be generic enough to be
handled by the regulator framework.

In the current situation we do have a pwr_en pin that can be controlled
by a GPIO or whatever signal from the SoC.
That's very similar, at PMIC level, to the fixedregulator that allow a
GPIO binding to enable it.

Don't you think that should deserve a support in the fmwk?

Regards,
Benoit
