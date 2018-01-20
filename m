From: gregkh@linuxfoundation.org (gregkh)
Date: Sat, 20 Jan 2018 09:32:52 +0100
Subject: ARM: SoC fixes for 4.15
In-Reply-To: <CAK8P3a2Ys-N3K+51gQ9Af+j+BdYR2SxJ6K24V+qz2odBzbdtAA@mail.gmail.com>
References: <CAK8P3a2Ys-N3K+51gQ9Af+j+BdYR2SxJ6K24V+qz2odBzbdtAA@mail.gmail.com>
Message-ID: <20180120083252.GA23243@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 19, 2018 at 05:12:15PM +0100, Arnd Bergmann wrote:
> The following changes since commit b2cd1df66037e7c4697c7e40496bf7e4a5e16a2d:
> 
>   Linux 4.15-rc7 (2018-01-07 14:22:41 -0800)
> 
> are available in the git repository at:
> 
>   ssh://git at gitolite.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> tags/armsoc-fixes
> 
> for you to fetch changes up to b7563e2796f8b23c98afcfea7363194227fa089d:
> 
>   phy: work around 'phys' references to usb-nop-xceiv devices
> (2018-01-19 16:12:37 +0100)
> 
> ----------------------------------------------------------------
> ARM: SoC fixes for 4.15
> 
> We have various small DT fixes, and one important regression fix:
> 
> The recent device tree bugfixes that were intended to address issues that
> 'dtc' started warning about in 4.15 fixed various USB PHY device nodes,
> but it turns out that we had code that depended on those nodes being
> incorrect and the probe failing with a particular error code. With the
> workaround we can also deal with correct device nodes.
> 
> The DT fixes include:
>  - Allwinner A10 and A20 had the display pipeline set up incorrectly
>    (introduced in v4.15)
>  - The Altera PMU lacked an interrupt-parent (never worked)
>  - Pin muxing on the Openblocks A7 (never worked)
>  - Clocks might get set up wrong on Armada 7K/8K (4.15 regression)
> 
> We now have  additional device tree patches to address all the remaining
> warnings introduced in 4.15, but decided to queue them for 4.16 instead,
> to avoid risking another regression like the USB PHY thing mentioned
> above.
> 
> ----------------------------------------------------------------
> 
> [note: I originally sent the phy-core patch to Greg with Kishon's
>  ack, as drivers/phy stuff tends to go that route but got no reply
>  over the last week, so I'm including it here instead. As the bug
>  was introduced through arm-soc, this seems like the best way
>  to now make sure we fix it before the release.]

No objection from me for this.

thanks,

greg k-h
