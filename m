From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 22 Oct 2012 10:21:51 -0700
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <20121019193847.GJ1613@blackmetal.musicnaut.iki.fi> (Aaro
 Koskinen's message of "Fri, 19 Oct 2012 22:38:47 +0300")
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
 <20121019190358.GI1613@blackmetal.musicnaut.iki.fi>
 <20121019190136.GA4229@arwen.pp.htv.fi>
 <20121019193847.GJ1613@blackmetal.musicnaut.iki.fi>
Message-ID: <87y5iyfmmo.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aaro Koskinen <aaro.koskinen@iki.fi> writes:

> Hi,
>
> On Fri, Oct 19, 2012 at 10:01:36PM +0300, Felipe Balbi wrote:
>> On Fri, Oct 19, 2012 at 10:03:58PM +0300, Aaro Koskinen wrote:
>> > FYI, I saw I2C hangs also on Nokia N900 with v3.7-rc1 (omap_i2c
>> > omap_i2c.1: timeout waiting for bus ready). After several reboots they
>> > disappered (kernel binary was the same), and I have been unable to
>> > reproduce them since.
>> 
>> any change you have those logs saved somewhere ? Want to see if it's the
>> same problem triggered by RTC.
>
> I did not save the logs, but now I tried again, I managed to reproduce
> it after couple boots. The log is below, and after that the there's also
> one from OK boot for comparison.
>
> In the error case, the boot never reaches userspace, just silently hangs
> (or maybe I just didn't wait enough long).

Can you try to revert the threaded IRQ conversion to see if things get
to working again?  commit 3b2f8f82dad7d1f79cdc8fc05bd1c94baf109bde

Thanks,

Kevin
