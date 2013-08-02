From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Aug 2013 01:13:15 -0700
Subject: [Ksummit-2013-discuss] [ATTEND] [ARM ATTEND] kernel data bloat
 and how to avoid it
In-Reply-To: <20130731152131.GW2296@suse.de>
References: <20130731073802.GT7656@atomide.com> <20130731152131.GW2296@suse.de>
Message-ID: <20130802081315.GA7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mel Gorman <mgorman@suse.de> [130731 08:28]:
> On Wed, Jul 31, 2013 at 12:38:03AM -0700, Tony Lindgren wrote:
> > Hi all,
> > 
> > Probably the biggest kernel data bloat issue is in the ARM land, but
> > it also seems that it's becoming a Linux generic issue too, so I
> > guess it could be discussed in either context.
> > 
> 
> Would scripts/bloat-o-meter highlight where the growth problems are?

Well to some extent yes, the board/SoC/driver specific options are
often behind Kconfig options. So if you want to limit the set of
supported SoCs and drivers for the kernel you can optimize it out.

The bloat-o-meter won't help for things like checking that a device
tree binding really describes the hardware, and is not just pointing
to a table of defined registers in the device driver.

A lot of the board specific, SoC specific, driver specific, debug
specifc and so on "data" should not be in the kernel to start with
and we can provide the same level of supported features in the kernel.

Regards,

Tony
