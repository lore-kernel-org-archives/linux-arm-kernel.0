From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 09 Apr 2013 16:56:08 +0200
Subject: [PATCH 0/3] sunxi: unify main oscillator and its gate
In-Reply-To: <1365515284-32061-1-git-send-email-emilio@elopez.com.ar>
References: <1365515284-32061-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <51642C08.6070600@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On 04/09/2013 03:48 PM, Emilio L?pez wrote:
> Hi Mike,
> 
> As discussed previously when introducing the sunxi driver, this patchset
> unifies the main oscillator ("osc24M_fixed") and its gate ("osc24M")
> into a single clock ("osc24M"). It does so by adding fixed-rate support
> into the composite clock and then using it to implement the new clock.
> 
> The changes shouldn't require any modifications on current/future users 
> of the composite clock, although I haven't tested any to make sure of 
> it. @Prashant, can I get a tested-by from you if necessary?

This patch set is a nice improvement, now we will have the best of the
two worlds: a 1-to-1 between the clock device in the device tree and the
real hardware clock on one side, and the reuse of existing driver clock
on the other side.

Could you indicate on which branch this patch set can be applied ? In
3.9-rc6 there is no file drivers/clk/clk-composite.c. I guess it should
be the something like clk-next or clk-for-3.10 from Mike's git tree.

Adding the branch where to apply the patch set is a good information to
add to the cover letter of a patch set.

Thanks,

> 
> Thanks,
> 
> Emilio
> 
> Emilio L??pez (3):
>   clk: composite: Add fixed-rate support
>   clk: sunxi: Unify oscillator clock
>   ARM: sunxi: unify osc24M_fixed and osc24M
> 
>  arch/arm/boot/dts/sunxi.dtsi  |  8 +-----
>  drivers/clk/clk-composite.c   | 57 ++++++++++++++++++++++++++++++++++++++++---
>  drivers/clk/sunxi/clk-sunxi.c | 30 +++++++++++++++++------
>  include/linux/clk-provider.h  |  6 +++++
>  4 files changed, 83 insertions(+), 18 deletions(-)
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
