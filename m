From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 17 Sep 2013 14:09:57 -0400
Subject: mvebu: Armada XP doesn't boot in v3.12-rc1
In-Reply-To: <20130917173502.GA4231@localhost>
References: <20130917173502.GA4231@localhost>
Message-ID: <20130917180957.GI19937@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel!

On Tue, Sep 17, 2013 at 02:35:03PM -0300, Ezequiel Garcia wrote:
> Armada XP boards are not booting in v3.12-rc1.
> 
> These two patches, which are already in linux-mvebu/mvebu/dt,
> are needed to fix the problem:
> 
> commit 585b136b73696ac37c9614b4b3d8fa0407adcdf1
> Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Date:   Tue Aug 20 12:45:51 2013 -0300
> 
>     ARM: mvebu: Add clock properties to Armada XP timer node
> 
> commit d36fd447d5e2d0993a8ec34afc26fc449ac1e2f3
> Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Date:   Tue Aug 20 12:45:50 2013 -0300
> 
>     ARM: mvebu: Add the reference 25 MHz fixed-clock to Armada XP

Yes, I saw that tglx sent a late pull for corresponding driver changes.
I'll move these two over to mvebu/fixes shortly.

> FWIW, CONFIG_HAVE_ARM_ARCH_TIMER=y is also needed or the board freezes,
> but that's another problem which I'm currently investigating.

Sounds like we just need a select, is there something more to it?

Please send a patch as soon as you have it nailed down.  I'd like the
two changes above and this patch to spend a few days in -next before I
send the pull.

> Can you push the above two to be included in v3.12-rc1 or do you need
> anything else from me?

Nope, confirmation of boards failing to boot is all I need to move these
over for v3.12.

thx,

Jason.
