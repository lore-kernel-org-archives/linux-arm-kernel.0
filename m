From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 14 Jul 2010 08:31:55 +0300
Subject: [PATCH 0/6] debug macro fixups
In-Reply-To: <1279074759.517724.734812272398.0.gpush@pororo>
References: <1279074759.517724.734812272398.0.gpush@pororo>
Message-ID: <20100714053154.GA15994@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On Wed, Jul 14, 2010 at 10:32:39AM +0800, Jeremy Kerr wrote:
> As part of the DEBUG_LL mapping changes, I ran all of the defconfigs
> with DEBUG_LL=y. Some of the configs are broken, so I'm posting the
> fixups.
> 
> mx1 is still broken, as IMX_IO_ADDRESS() (used by the mx1 debug macros)
> uses C syntax, and so it not suitable for asm.

You can use the patches from 
http://thread.gmane.org/gmane.linux.ports.arm.kernel/75691 to make mx1 (and 
mx25) pass your tests.

baruch

> These changes are on top of the DEBUG_LL mapping changes.
> 
> Cheers,
> 
> 
> Jeremy
> 
> ---
> Jeremy Kerr (6):
>       arm/clps711x: fix debug macro compilation failure
>       arm/h720x: fix debug macro compilation failure
>       arm/l7200: fix debug macro compilation failure
>       arm/plat-spear: fix debug macro compilation failure
>       arm/ns9xxx: fix debug macro compilation failure
>       arm/shark: fix debug macro compilation failure

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
