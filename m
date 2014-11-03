From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 3 Nov 2014 19:09:21 +0100
Subject: [PATCH 0/4] Touchscreen performance related fixes
In-Reply-To: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
Message-ID: <20141103180920.GA20779@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 04:38:27PM +0530, Vignesh R wrote:
> This series of patches fix TSC defects related to lag in touchscreen
> performance and cursor jump at touch release. The lag was result of
> udelay in TSC interrupt handler. Cursor jump due to false pen-up event.
> The patches implement Advisory 1.0.31 in silicon errata of am335x-evm
> to avoid false pen-up events and remove udelay.

That advisory has two workarounds. You have chosen the second one?

The text of the second workaround says it only works on 4 wire setups,
so I wonder how 5 wire designs will be affected.

> The advisory says to use
> steps 1 to 4 for ADC and 5 to 16 for TSC (assuming 4 wire TSC and 4 channel
> ADC).

No, it doesn't say that. (sprz360f.pdf)

> Further the X co-ordinate must be the last one to be sampled just
> before charge step. The first two patches implement the required changes. 

FWIW, I implemented the first workaround and removed the udelay not
too long ago. Like Sebastian, I saw the TSC unit hang after about
50000 interrupts when running with the workaround.

Did you test you patch for very long?

Thanks,
Richard
