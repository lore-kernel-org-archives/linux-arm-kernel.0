From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 3 Aug 2012 09:31:50 +0000
Subject: am33xx: default to status = "disabled"?
In-Reply-To: <201208022328.17095.arnd@arndb.de>
References: <501B061A.6080008@gmail.com> <201208022328.17095.arnd@arndb.de>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA7F557@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 03, 2012 at 04:58:16, Arnd Bergmann wrote:
> On Thursday 02 August 2012, Daniel Mack wrote:
> > currently, all devices in arch/arm/boot/dts/am33xx.dtsi are enabled by
> > default. However, depending on the actual board dts, only some of the
> > devices should actually be initialized, given that they only make sense
> > if their pins are actually wired on the board.
> > 
> > On other platform, such devices are marked with status = "disabled", and
> > the board files re-enable those they really use by overriding that
> > status again. That approach seems to make sense - shouldn't the same be
> > done in am33xx.dtsi or am I missing something?
> 
> I agree, they should be disabled, at least the serial ports, and probably
> also the i2c controllers.
> 

You are right, it needs to be disabled. I will create a patch and submit it.

Thanks,
Vaibhav
