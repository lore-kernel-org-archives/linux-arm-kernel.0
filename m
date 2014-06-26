From: tony@atomide.com (Tony Lindgren)
Date: Thu, 26 Jun 2014 00:42:09 -0700
Subject: [PATCH V4 00/16] irqchip: crossbar: Driver fixes
In-Reply-To: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
References: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
Message-ID: <20140626074209.GE28884@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sricharan R <r.sricharan@ti.com> [140626 00:14]:
> This series does some cleanups, fixes for handling two interrupts
> getting mapped twice to same crossbar and provides support for
> hardwired IRQ and crossbar definitions.
> 
> On certain platforms such as DRA7, SPIs 0, 1, 2, 3, 5, 6, 10,
> 131, 132, 133 are direct wired to hardware blocks bypassing
> crossbar. This quirky implementation is *NOT* supposed to be the
> expectation of crossbar hardware usage. This series adds support
> to represent such hard-wired irqs through DT and avoid generic
> allocation/programming of crossbar in the driver.
> 
> This way of supporting hard-wired irqs was a result of
> the below discussions.
> http://www.spinics.net/lists/arm-kernel/msg329946.html
> 
> Based on 3.16 rc2 mainline.

Jason, once these patches look OK for merging, can you please
set them up into an immutable branch so I too can merge them in?

The immutable branch is needed so I can eventually apply
the related .dts changes to enable the crossbar interrupts.

Regards,

Tony
