From: broonie@kernel.org (Mark Brown)
Date: Wed, 9 May 2018 18:18:16 +0900
Subject: [RFC PATCH] driver core: make deferring probe forever optional
In-Reply-To: <20180507223438.GB14924@minitux>
References: <20180501213114.20183-1-robh@kernel.org>
 <20180507183106.GF2259@tuxbook-pro>
 <CAL_Jsq+PRUR5rCeV820XZuQmQH3gD-X=6a5fNuF-9qVbq5dqFg@mail.gmail.com>
 <20180507223438.GB14924@minitux>
Message-ID: <20180509091816.GZ13402@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2018 at 03:34:38PM -0700, Bjorn Andersson wrote:

> And is this really a problem that does not exists in the ACPI world?

Sort of, in that on ACPI systems all devices are expected to live in
glorious isolation and anything they need transparently configured by
the firmware with any information about clock speeds or whatever coming
from proprietary/device specific properties (though that's severely
frowned upon) or the apparently idiomatic technique of hardcoding based
on DMI data which has some scalability issues.  This works great for
systems intended to work in the ACPI model but is not entirely
successful once you get outside of that.

Some of the embedded ACPI people have been importing bits of DT
wholesale into ACPI, for those bits obviously all the DT issues get
imported too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180509/63308370/attachment.sig>
