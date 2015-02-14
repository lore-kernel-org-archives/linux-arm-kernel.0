From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 14 Feb 2015 13:22:16 +0100
Subject: [PATCH 2/4] rtc: sa1100: convert to run-time register mapping
In-Reply-To: <1423005775-26457-3-git-send-email-robh@kernel.org> (Rob
 Herring's message of "Tue, 3 Feb 2015 17:22:53 -0600")
References: <1423005775-26457-1-git-send-email-robh@kernel.org>
 <1423005775-26457-3-git-send-email-robh@kernel.org>
Message-ID: <87386865tz.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> SA1100 and PXA differ only in register offsets which are currently
> hardcoded in a machine specific header. Some arm64 platforms (PXA1928)
> have this RTC block also.
>
> Convert the driver to use ioremap and set the register offsets dynamically.
> Since we are touching all the register accesses, convert them all to
> readl/writel.

All right Rob, to conclude this discussion, provided you add to the git comment
what we discussed, ie. that this patch opens the path to exclusive runtime usage
between rtc-sa1100 and rtc-pxa on pxa, I'll ack it.

If somebody complains, I'll tell him to develop the glue between sa1100 and pxa
as Russell suggested, or use only one of the drivers.

Cheers.

--
Robert
