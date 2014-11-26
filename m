From: tony@atomide.com (Tony Lindgren)
Date: Wed, 26 Nov 2014 15:14:36 -0800
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <201411270001.44871@pali>
References: <20141027200008.GR2560@atomide.com> <201411262022.03338@pali>
 <20141126200806.GO2817@atomide.com> <201411270001.44871@pali>
Message-ID: <20141126231435.GQ2817@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [141126 15:03]:
> On Wednesday 26 November 2014 21:08:06 Tony Lindgren wrote:
> 
> With your patch I'm getting:
> 
> Hardware        : Nokia RX-51 board
> 
> So patch is good.

Is that a Tested-by: then? :)
 
> > > Revision comes from bootloader (via ATAG) and it is HW
> > > revision of N900 device. It cannot be hardcoded into kernel
> > > or DTS as it it depends on HW.
> > 
> > Well for the "Revision" line problem, we could pass the
> > revision in cmdline or .dts if not passed in the legacy
> > ATAGs. It sounds like were just not copying it to system_rev
> > for DT based booting? Maybe it's just some missing
> > CONFIG_ATAG option that needs to be enabled?
> 
> Yes it looks like DT code does not read Revision ATAG... I tried 
> to enable everything but always same problem...

Maybe check if it shows up properly in /proc/atags or whatever
the interface for it was?

The build_tag_list() should parse ATAG_REVISION and then
parse_tag_revision() should copy it to system_rev. Maybe try
adding some printks to see if those functions get called?

Regards,

Tony
