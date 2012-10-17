From: x0148406@ti.com (Afzal Mohammed)
Date: Wed, 17 Oct 2012 10:59:47 +0530
Subject: [PATCH v2 00/14] OMAP-GPMC related cleanup for common zImage
In-Reply-To: <20121016180600.GA15569@atomide.com>
References: <cover.1349672877.git.afzal@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9F7B0A@DBDE01.ent.ti.com>
 <20121010163840.GA13585@parrot.com> <20121016180600.GA15569@atomide.com>
Message-ID: <507E424B.8040706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ivan,

On Tuesday 16 October 2012 11:36 PM, Tony Lindgren wrote:
> * Ivan Djelic<ivan.djelic@parrot.com>  [121010 09:40]:

>> I ran several mtd regression tests on a Beagle Board on your gpmc-czimage-v2 tag.
>> All BCH error correcting tests passed successfully.

>> I occasionally had weird read errors though, especially when reading blank pages:
>> the omap driver returned 512-byte sectors containing something like:

>> I was able to reproduce the problem also on l2-mtd tip, albeit less often.
>> The problem seems to occur quite randomly, it may be a hardware issue on
>> my board...

> Things like this typically happen in the GPMC timings are not correct.
> Maybe add #define DEBUG to top of gpmc.c and compare the timings
> before and after Afzal's patches?

Latest series for gpmc related cleanup for common zImage removed
dependency on minor timing cleanups (this series was dependent on
on another series that did minor timing cleanups).

A pull request for the new series on gpmc cleanup for common zImage
that does not contain timing related changes and without dependency
on timing related changes has been sent to Tony (forwarded to you now).
He has pulled those changes onto l-o in
"omap-for-v3.8/cleanup-headers-gpmc"

As there are no changes w.r.t timing's in the new series, behaviour
should be same as without.

>> Anyway, the ECC handling part looks OK to me.

Regards
Afzal
