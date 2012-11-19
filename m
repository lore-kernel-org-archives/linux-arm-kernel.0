From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Nov 2012 19:27:01 +0100
Subject: arm: mvebu: Various mvebu clock fixes/improvements
In-Reply-To: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121119182701.GS14643@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 05:52:36PM +0100, Thomas Petazzoni wrote:
> Andrew,
> 
> You'll find enclosed seven patches brigging fixes and improvements to
> the CLK support on mvebu platforms. You can either squash them into
> your current clk series if you intend to send a new version of it to
> Jason, or forward the patches as follow-up patches to Jason after
> reviewing.
> 
> In summary:
> 
>  * Patch 1 fixes a real problem: the gating clocks are not registered
>    on Armada 370/XP.
> 
>  * Patch 2, 3, 5 and 6 are more cosmetic patches, but I think they are
>    good to have.
> 
>  * Patch 4 implements a fix that we've been discussing: moving the
>    Armada XP CPU clocks down to the individual armada-xp-mv78xxx.dtsi
>    files.
> 
>  * Patch 7 fixes the references to the SATA clocks on Armada
>    370/XP. Without this patch, Armada 370 currently hangs at boot when
>    trying to initialize SATA.

Hi Thomas

You probably want patch 1 last. Anybody bisecting this changeset if
going to have a hung 370/XP.

      Andrew
