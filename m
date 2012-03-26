From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Mar 2012 08:37:04 +0100
Subject: Inconsistent kallsyms data on ARM.
In-Reply-To: <4F6FB170.1040109@jonmasters.org>
References: <CAP=VYLoStscdVJretZ-Rkbp7V3Vsm8N0oWcjih7ruHFiDN7CiA@mail.gmail.com>
 <201203141321.47010.arnd@arndb.de>
 <20120325112035.GE5611@n2100.arm.linux.org.uk>
 <4F6FB170.1040109@jonmasters.org>
Message-ID: <20120326073704.GH5611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 25, 2012 at 07:59:44PM -0400, Jon Masters wrote:
> As to longer term, I am happy to work up something that will spot this
> particular kind of failure (symbol changes type) and output something
> more useful during the kallsyms generation if you would like.
> 
> Are you planning to pull in either of the fixes you mention?

I'm not, because those are all sub-optimal - I don't see why we should
bloat the kernel image just for the sake of working around kallsyms.

The best I've come up with so far which avoids that is to force
KALLSYMS_EXTRA_PASS to always be set on ARM.
