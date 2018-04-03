From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 3 Apr 2018 11:03:30 -0500
Subject: [PATCH 0/7] sunxi: Add DT representation for the MBUS controller
In-Reply-To: <cover.54a07919b9d7fe8d7c90e9f4929648013e641cff.1522761929.git-series.maxime.ripard@bootlin.com>
References: <cover.54a07919b9d7fe8d7c90e9f4929648013e641cff.1522761929.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAL_Jsq+cURC780ivftY1v3P59g5UKAHwb48raXXB6huQ2KBvuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 3, 2018 at 8:29 AM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> Hi,
>
> We've had for quite some time to hack around in our drivers to take into
> account the fact that our DMA accesses are not done through the parent
> node, but through another bus with a different mapping than the CPU for the
> RAM (0 instead of 0x40000000 for most SoCs).
>
> After some discussion after the submission of a camera device suffering of
> the same hacks, I've decided to put together a serie that introduce a
> property called dma-parent that allows to express the DMA relationship
> between a master and its bus, even if they are not direct parents in the DT.

Reading thru v6 of the camera driver, it seems like having
intermediate buses would solve the problem in your case?

As Arnd mentioned in that thread, something new needs to address all
the deficiencies with dma-ranges and describing DMA bus topologies.
This doesn't address the needs of describing bus interconnects.
There's been some efforts by the QCom folks with an interconnect
binding. They've mostly punted (for now at least) to not describing
the whole interconnect in DT and keeping the details in a driver.

On the flip side, this does mirror the established pattern used by
interrupts, so maybe it's okay on it's own. I'll wait for others to
comment.

Rob
