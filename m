From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 10 Oct 2012 11:29:03 -0700
Subject: [RFC 00/24] OMAP serial driver flow control fixes,
 and preparation for DMA engine conversion
In-Reply-To: <507427DA.6020409@ti.com> (Sourav's message of "Tue, 9 Oct 2012
 19:04:18 +0530")
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
 <507427DA.6020409@ti.com>
Message-ID: <87mwzuxjtc.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sourav,

Sourav <sourav.poddar@ti.com> writes:

[...]

> Boot Tested this patch series against v3.6 tag(applied cleanly) on
> panda board and
> PM tested(hitting off in Idle and suspend) on omap3630 based beagle board.
>
> Note, I also tested the patches against the current master but only
> after rebasing, since the current master includes serial patches from
> Felipe Balbi[1].
> [1] https://lkml.org/lkml/2012/8/24/139
>
> Tested-by: Sourav Poddar <sourav.poddar@ti.com>

Did you test flow control after off-mode transitons?

Russell indicated that the context save/restore is not saving important
bits related to HW flow control, so I suspect some more testing,
specifically of flow control after off-mode is needed.

Kevin
