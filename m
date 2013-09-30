From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 30 Sep 2013 10:09:13 -0400
Subject: [PATCH, FIX] ARM: mvebu: fix ReadyNAS 102 Power button GPIO to
 make it active high
In-Reply-To: <87ob7bh3uu.fsf@natisbad.org>
References: <87ob7bh3uu.fsf@natisbad.org>
Message-ID: <20130930140913.GD31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 29, 2013 at 08:36:41PM +0200, Arnaud Ebalard wrote:
> 
> NETGEAR ReadyNAS 102 Power button definition in .dts file flags
> associated GPIO active low instead of active high. This results
> in reversed events reported by input subsystem (0 returned when
> the button is pressed, 1 when released). This patch makes
> associated GPIO active high to recover correct behaviour.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
> RN102 .dts file sits in Linus tree only since 3.12-rc1 so I guess
> no one has currently relied on current reversed behaviour, i.e.
> this can be fixed w/o impact on any userspace program. As a side
> note, the initial error is mine.
> 
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to mvebu/fixes

thx,

Jason.
