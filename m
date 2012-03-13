From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Mar 2012 10:07:57 -0700
Subject: [PATCH 12/12] ARM: OMAP2+: board-omap4-*: Do not use anymore
 TWL6030_IRQ_BASE in board files
In-Reply-To: <1330707024-23730-13-git-send-email-b-cousson@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
 <1330707024-23730-13-git-send-email-b-cousson@ti.com>
Message-ID: <20120313170756.GK12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [120302 08:19]:
> With the introduction of dynamically allocated IRQ in the twl6030 driver,
> the board files can no longer rely of static IRQ defines like before.
> 
> Retrieve the value dynamically allocated from the mmc -> twl6030 init
> callback.
> 
> Note: The Panda board does not seems to use the card detect IRQ.

Looks like this one is safe to merge via MFD and does not seem to
cause any merge conflicts.

This one should be folded into patch 08/12 to avoid boot issues
for between patches 08 and 12 in this series. Other than that:

Acked-by: Tony Lindgren <tony@atomide.com>
