From: cjb@laptop.org (Chris Ball)
Date: Wed, 17 Nov 2010 00:34:29 +0000
Subject: [PATCH] mmci: handle clock frequency 0 properly
In-Reply-To: <1289927869-14519-1-git-send-email-linus.walleij@stericsson.com>
References: <1289927869-14519-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101117003429.GA2578@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Nov 16, 2010 at 06:17:49PM +0100, Linus Walleij wrote:
> This removes the default clocking for the MMCI controller so that
> the external MCI card clock does not activate until the first
> .set_ios() call is issued. It will further handle the transitions
> from a clock != 0 to 0 and vice versa by gating/ungating the
> clock with clk_disable()/clk_enable().
> 
> This assures that the MCI clock will not be active unless there
> is a card in the MMC slot.
> 
> By default the MMC core will not gate off the clock to a card
> once it's enabled, but with the separate patch for aggressive
> clocking this can optionally be enabled for the system.
> 
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> Changes since v8:
> 
> The frequency registers shall be set with mmci_set_clkreg()
> no matter whether the clock gets enabled or disabled, systems
> without a clk framework will need this so that the clock
> dividers are set to the apropriate values for clock 0 as
> well, and that will probably mitigate power consumption
> somewhat on these systems.
> 
> Chris: this is a new version after Russell found an error in
> it. Can you please take the old version of this patch out of
> the MMC tree so I can merge it through Russells ARM tree
> instead? The patches are perfectly orthogonal so it doesn't
> need to live in the MMC tree.

Okay, this patch has been removed from mmc-next now.

(I'm holding off on pulling the rest of your latest patchset until
you reply to David Vrabel's review of [2/3] -- let me know if you
think it should be pulled now instead.)

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
