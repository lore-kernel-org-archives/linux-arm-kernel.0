From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 30 Sep 2013 10:13:01 -0400
Subject: [PATCH] ARM: mvebu: Add DT entry for ReadyNAS 102 to use
 gpio-poweroff driver
In-Reply-To: <8738onqp9k.fsf@natisbad.org>
References: <8738onqp9k.fsf@natisbad.org>
Message-ID: <20130930141301.GE31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 29, 2013 at 11:41:43PM +0200, Arnaud Ebalard wrote:
> 
> Without that fix, at the end of the shutdown process, the board is
> still powered (led glowing, fan running, ...).
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
> HI Jason and Andrew,
> 
> This is not per se a fix for a real problem, as the NAS runs
> as expected w/o it, it only solves a minor limitation of the
> shutdown process so I guess it can be queued for 3.13 if it
> is too late.

I consider a server not being able to automatically reboot unattended to
be a regression.  ;-)

> Additionally, I wonder if I should send another patch to either have
> ARCH_MVEBU select POWER_SUPPLY, POWER_RESET and POWER_RESET_GPIO,
> or have mvebu_defconfig modified to enable those, or keep things as
> they are until there are more users on mvebu.

I'm inclined towards select, but I also agree that there's no rush.

>  arch/arm/boot/dts/armada-370-netgear-rn102.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied to mvebu/fixes for v3.12.

thx,

Jason.
