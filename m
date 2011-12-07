From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Dec 2011 23:50:26 +0100
Subject: [PATCH v4 5/6] ARM: vexpress: DT-based support for Cortex-A5 and
 Cortex-A9 based tiles
In-Reply-To: <1323284788.32116.11.camel@hornet.cambridge.arm.com>
References: <1323186229-22054-1-git-send-email-pawel.moll@arm.com>
 <27584177.XzoGq1stOI@wuerfel>
 <1323284788.32116.11.camel@hornet.cambridge.arm.com>
Message-ID: <3031582.pcIGOLc7WK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 December 2011 19:06:28 Pawel Moll wrote:
> On Tue, 2011-12-06 at 23:13 +0000, Arnd Bergmann wrote:
> > Actually, I have to take that back. Looking at both patch 5 and 6,
> > the dt-ca*.c files are almost identical and all the differences are about stuff
> > that you can find in the device tree:
> 
> You are obviously right - I was rushing with that. Less is better then
> more  Will respin tomorrow.

Ok, great!

> > * The iotable gets initialized from "mrc p15, 4, %0, c15, c0, 0", which would
> > be fine if that worked on all machines, but in order to unify the two
> > files, I would recommend searching the flat device tree for the respective
> > node and only map it if present.
> > 
> > * You have two ways of finding out the number of cores, but looking in
> > the device tree would just work either way.
> 
> Those two are actually related, as it's all about memory mapped SCU in
> case of A5/A9 and CP15-controlled on A7/15 (the *smp_enable() is
> different as well).
> 
> I'll probably just define a "scu" node compatible with
> "arm,cortex-a9-scu" and use the A5/A9 SMP callbacks if it's present (and
> create static mapping for it) or the A7/15 if it's missing.

Fair enough.

	Arnd
