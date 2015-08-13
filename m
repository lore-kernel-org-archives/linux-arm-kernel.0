From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 13 Aug 2015 16:54:47 +0200
Subject: [PATCH v3] ARM: tegra: cpuidle: implement
 cpuidle_state.enter_freeze()
In-Reply-To: <1432046953-12945-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1432046953-12945-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150813145446.GD26559@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 04:49:12PM +0200, Tomeu Vizoso wrote:
> This callback is expected to do the same as enter() but it has to
> guarantee that interrupts aren't enabled at any point in its execution,
> as the tick is frozen.
> 
> It will be called when the system goes to suspend-to-idle and will
> reduce power usage because CPUs won't be awaken for unnecessary IRQs.
> 
> By setting the CPUIDLE_FLAG_TIMER_STOP flag, we can reuse the same code
> for both the enter() and enter_freeze() callbacks.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> ---
> 
> v3:	* Set CPUIDLE_FLAG_TIMER_STOP to simplify things as suggested by
> 	Lorenzo Pieralisi
> v2:	* Disable FIQs also when suspending-to-idle
> ---
>  arch/arm/mach-tegra/cpuidle-tegra114.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150813/06f41e28/attachment.sig>
