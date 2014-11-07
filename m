From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 7 Nov 2014 16:49:40 +0100
Subject: [PATCH v2 06/11] memory: atmel-ebi: add DT bindings documentation
In-Reply-To: <CAL_JsqJvT-gnr6AYHq42qfgS+ckZ1y6DFiPK5+-MBhHefB8_Sg@mail.gmail.com>
References: <1415203287-21517-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415203287-21517-7-git-send-email-boris.brezillon@free-electrons.com>
 <CAL_JsqJvT-gnr6AYHq42qfgS+ckZ1y6DFiPK5+-MBhHefB8_Sg@mail.gmail.com>
Message-ID: <20141107164940.663f5423@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Nov 2014 09:21:39 -0600
Rob Herring <robherring2@gmail.com> wrote:

> On Wed, Nov 5, 2014 at 10:01 AM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Perhaps some commit msg?

Yes, I was just lazy and though this series would make another round
anyway :-).

I'll add a commit log to all my commits...

> 
> While this binding seems mostly okay to me, this is the 2nd memory
> controller binding I've looked at in the last day [1]. There are
> probably some others already as well. This makes me think we need a
> generic binding here. At least the node structure and how we define
> chip selects should be common.

Sure.
Any suggestion ?

BTW, I don't use any specific property to define the chip select
associated to a device, because it's already encoded in the reg
property.
TI AEMIF binding define an ti,cs-chipselect property, is there any
reason for doing that ?

Moreover, IMHO it would even make sense to have some sort of
framework/helper functions for those kind of interfaces to external
memories, but this is another story :-).

> 
> While I like timing information in time units over magic register
> values in the Tegra binding, the reality is converting timing info to
> register values is generally very hard to get both correct and
> optimal. In the end, you probably need to hand tweak the register
> settings anyway. So I'm hesitant to say it must be done 1 way here.

Well, I'm not a big fan of timings expressed in clock cycles, cause
this implies changing your DT when you tweak your master/bus clk.
Expressing those timings in nano or pico seconds let the driver figure
out what's the best value according to the current source clk rate.

Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
