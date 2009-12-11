From: daniel@caiaq.de (Daniel Mack)
Date: Sat, 12 Dec 2009 07:47:14 +0800
Subject: "ARM: MX3: fix CPU revision number detection" breaks QONG support
In-Reply-To: <20091211143318.1D8B43F6CC@gemini.denx.de>
References: <20091211143318.1D8B43F6CC@gemini.denx.de>
Message-ID: <20091211234714.GT28375@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2009 at 03:33:18PM +0100, Wolfgang Denk wrote:
> commit v2.6.32-rc6-49-g52939c0 "ARM: MX3: fix CPU revision number
> detection" breaks booting on the QONG board - there is no output on
> the console any more after this commit is added.
> 
> Do you have any idea in which area I should start looking for the
> cause of this problem?

Yes, Vaentin Lonchamp (cc) also reported that problem. The problem seems
to be related to things the bootloader does to your board, and I'm not
sure yet where the difference is between the MX31 LiteKit and others. My
suspect was that the clocks are not set up properly, but they have been
reported to be ok. What fails is a single register access. Maybe access
to this function block needs to be enabled or unlocked or something?
Unfortunately, as the LoLo bootloader on this board does not ship with
sources, I'm fishing in muddy waters.

Next problem is that I'm currently abroad and don't have access to MX3
hardware. As soon as I'm back, I'll try more boards and see if they
behave differently.

In the meantime, if nobody is able to figure out the root cause, we
might consider reverthing this patch.

Sorry for the trouble caused.

Daniel
