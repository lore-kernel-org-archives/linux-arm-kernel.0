From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 22 Jun 2018 13:05:25 -0400 (EDT)
Subject: [PATCHv4 4/4] ARM: versatile: support configuring versatile
 machine for no-MMU
In-Reply-To: <TY1PR01MB15624342267F973525BF45698A750@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20180618141905.7789-1-gerg@linux-m68k.org>
 <20180618141905.7789-5-gerg@linux-m68k.org>
 <CAMuHMdUyCEq0U_CJindwcSEF+0dR-SJc1v8zGT-CcUqVkdOeVw@mail.gmail.com>
 <nycvar.YSQ.7.76.1806211212010.16670@knanqh.ubzr>
 <20180622110145.GU17671@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1806221110140.16670@knanqh.ubzr>
 <CAMuHMdWZPM3Q9fVXWiw1bMVWNRCYGoQa-XukJka-2xsP-=HmVQ@mail.gmail.com>
 <nycvar.YSQ.7.76.1806221146140.16670@knanqh.ubzr>
 <TY1PR01MB15624342267F973525BF45698A750@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Message-ID: <nycvar.YSQ.7.76.1806221244490.16670@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Jun 2018, Chris Brandt wrote:

> On Friday, June 22, 2018 1, Nicolas Pitre wrote:
> > All that is possible already. But config symbol mutual exclusion is not.
> 
> I still don't understand why we need some false sense of security for 
> only selecting 1 platform.

Because that's the right thing to do. Small hacks are nice, but when 
they accumulate (and they always do over time) then maintainability 
suffers. This is why you may do whatever small hacks in your own copy of 
the kernel code and that might be good enough, but the mainline source 
tree should be held to higher standards.

> There are probably plenty of kernel config options that you could enable
> that would break any number of systems.

That's no excuse to add more of them. Many people are constantly working 
to move things in the other direction.

> So, why do we feel that XIP_KERNEL needs a warm safety blanket around 
> it?

Because we simply try not to create invalid kernel configurations. 
XIP_KERNEL is not more special than other symbols in that respect.

And if the kconfig language has to be extended for proper configurations 
to be produced then that's what it is, and trying to cheat around that 
fact won't produce any good.


Nicolas
