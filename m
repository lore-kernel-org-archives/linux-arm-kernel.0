From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 17 Mar 2015 13:29:01 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <20150317102623.GS8656@n2100.arm.linux.org.uk>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20150317102623.GS8656@n2100.arm.linux.org.uk>
Message-ID: <HK2PR06MB056127B8977A6F0FC1EF61E58A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  While I can see that reasoning, in part in this instance that was due to XIP not seeming to have many users (and its only users were old platforms...

I would say XIP has just been waiting for the right part to come alone. The ARCH_R7S72100 has 10MB of internal RAM and can execute directly from external Quad-SPI flash (no DDR, no NOR).
I also dusted off the Advanced XIP File System (AXFS) so now userland uses as little RAM as possible as well.

> We've run into the need a few times now to allow a SoC family converted to multiplatform to also be chosen using the previous non-multiplatform behaviour.

If Linux only ran on PCs, then maybe this wouldn't be such an issue. But with Linux on an SoC, you can (and should) get creative with what you are making. ARCH_MULTIPLATFORM seems to suppress that.

> What I believe is that rather than ripping out the old platform choices, we should have augmented them with the multiplatform support instead

Agreed.

> One thing which the whole multiplatform/DT project has taught me though is that the above approach is virtually always wrong

The one nice thing DT does is clean up and consolidate the mundane stuff in the board file, but that didn't mean I wanted you to take the board file completely away from me.

> That can be worked around with a progressive approach to converting this stuff in a way that ensures we gain the new symbols in people's defconfigs before we switch things around.

Since either way this sounds like a long process, and I still want to see if I can get XIP working with the latest kernel, will you accept patches on something that can't be built with the current architecture?
 
Chris
