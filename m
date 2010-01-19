From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 19 Jan 2010 17:10:33 +0000
Subject: [RFC 18/18] arm: mm: qsd8x50: Fix incorrect permission faults
In-Reply-To: <20100111231143.GF7925@n2100.arm.linux.org.uk>
Message-ID: <20100119171033.GA1323@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Jan 11, 2010 at 02:47:37PM -0800, Daniel Walker wrote:
> > From: Dave Estes <cestes@quicinc.com>
> > 
> > Handle incorrectly reported permission faults for qsd8650.  On
> > permission faults, retry MVA to PA conversion.  If retry detects
> > translation fault.  Report as translation fault.
> 
> This is totally unacceptable to add such a demanding copyright header to
> any file, imposing this notice upon pre-existing code.  Please remove it.

Other files also.

I was going to enquire about another file in this patch, wondering if
the long copyright header is compatible with the GPLv2 used for the
kernel tree as a whole:

--- /dev/null
+++ b/Documentation/arm/msm/emulate_domain_manager.txt
@@ -0,0 +1,282 @@
+Copyright (c) 2009, Code Aurora Forum. All rights reserved.
+
+[... longish license header, like new BSD but different...

Notably:

+Redistributions in source form must retain the above copyright notice, this
+list of conditions and the following disclaimer as the first lines of this
+file unmodified.

So nobody can add a title to the documentation, add another copyright
year and name, convert it to Docbook, etc....?

But also, the simple fact that it is not a standard license raises the
question of whether it's acceptable at all.


For another file, I'm not sure that adding "All rights reserved" is ok.
Under the GPL, all rights are _not_ reserved:

--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -2,6 +2,7 @@
  *  linux/arch/arm/mm/fault.c
  *
  *  Copyright (C) 1995  Linus Torvalds
+ *  Copyright (c) 2009, Code Aurora Forum. All rights reserved.
  *  Modifications for ARM processor (c) 1995-2004 Russell King
  *
  * This program is free software; you can redistribute it and/or modify


-- Jamie
