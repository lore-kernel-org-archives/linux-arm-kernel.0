From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Oct 2013 08:41:03 -0700
Subject: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
In-Reply-To: <52525642.8010307@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <524EE00F.7010208@ti.com> <20131007021556.GV8949@atomide.com>
 <52525642.8010307@ti.com>
Message-ID: <20131007154103.GW8949@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [131006 23:43]:
> On 10/07/2013 05:15 AM, Tony Lindgren wrote:
> >* Tero Kristo <t-kristo@ti.com> [131004 08:42]:
> >>Hi,
> >>
> >>Just a gentle reminder, anybody have any comments on this series or
> >>should we start queuing stuff?
> >
> >Well omap4 seems to work for me just fine, and omap3 in legacy
> >mode. But looks like omap3 device tree based booting is breaking
> >after I pulled in your test branch. I get the following on
> >3630 based dm3730.
> 
> Uart4 breaks because of the issue with basic DT blobs. You need at
> least this patch:
> 
> http://linux-kernel.2935.n7.nabble.com/RFC-PATCH-ARM-OMAP3630-Add-generic-machine-descriptor-td722791.html
> 
> ... from Nishanth to get it to work right. Otherwise the clock init
> tries to use omap3430 clock data for omap3630 which leaves uart4
> nodes out.

OK thanks yes that solves it, I was missing the compatible flag
for my not quite ready test boards (3730-evm and zoom3).
I'll apply Nishant's fix with some changes.

Then for this series, once you have the necessary acks, can you
please split into following two separate immutable branches
against v3.12-rc3:

1. clock code changes

2. dts changes

Then those can be pulled in as needed by Benoit, Mike and I.

For the whole series, I think this quite nicely removes some
nasty kernel data dependencies for omaps, so feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony
