From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 26 May 2013 23:23:29 +0200
Subject: [RFC PATCHv4 0/6] arm: Initial TI-Nspire support
In-Reply-To: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
Message-ID: <201305262323.29519.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 25 May 2013, Daniel Tang wrote:
> Changes between v3 and v4:
> * Remove redundant clock-names in device tree
> * Re-enable bus access to some peripherals on bootup
> * Clean up nspire-classic-timer code.
>   - Implement a nspire_timer_set_mode function
>   - Removed messy IO_MATCHx and CNTL_MATCHx macros
>   - Timer starts disabled to begin with
>   - Interrupt handling code return IRQ_NONE for spurious interrupts
>   - Delete unnessecary shift
> * Change clk-nspire to use compatible property to determine IO type
> * Change device tree bindings to have appropriate vendor prefixes
> * Added device tree binding documentation
> * Fix incorrect register addresses for clocks
> * Use more specific .caps for CLCD

Looks really good now. I have a few more comments for the first patch,
mostly for stuff that can be simplified based on stuff we merged in 3.10.

The one remaining bit that sticks out is the clcd platform data. As I
said before, I won't require you to convert that to DT in order to
get your code merged, but I'd also really like to see that happen,
as we will also need that to get rid of auxdata on the ARM reference
platforms (integrator, versatile, realview, vexpress).

Are you motivated to look into those after the base patch gets
merged into arm-soc?

One comment on the merge path: While we can put any of the patches
into the arm-soc tree, my preference is definitely for the clk,
clksource, irqchip and input drivers to go through the respective
maintainer trees. There are no dependencies to worry about, since
each patch can compile standalone, and we just need to make sure
they all get into 3.11 for your platform to work.

	Arnd
