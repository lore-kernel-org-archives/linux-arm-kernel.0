From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 12 Apr 2017 19:16:56 +0200
Subject: [PATCH v5 0/4] gpio: mvebu: Add PWM fan support
In-Reply-To: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
References: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
Message-ID: <20170412171656.GC11964@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 09, 2017 at 08:09:26PM +0200, Ralph Sennhauser wrote:
> Hi Therry,
> 
> Resending this as v5 with some minor changes since v4. What is missing is
> an ACK from you so Linus can merge the driver and Gregory the dts
> changes. For this driver to make it into 4.12 it would be nice to have
> it in next soon. I hope you can make some room in your schedule to have
> another look at this series.
> 
> Thanks
> Ralph
> 
> ---
> 
> Notes:
> 
>   About npwm = 1:
>     The only way I can think of to achieve that requires reading the
>     GPIO line from the device tree. This would prevent a user to
>     dynamically choose a line. Which is fine for the fan found on Mamba
>     but let's take some development board with freely accessible GPIOs
>     and suddenly we limit the use of this driver. Given the above, npwm
>     = ngpio with only one usable at a time is a more accurate

I think "accurate" is perhaps not the word I'd choose. "npwm" is defined
as "number of PWMs controlled by this chip", and that's effectively just
the one. It's implied that all PWMs exposed by a chip can be used
concurrently.

Anyway, I can see how npwm = ngpio might be more convenient, and if that
is what you want to do, I don't feel strongly enough to object.

>     description of the situation. The only downside is some "wasted"
>     space.
> 
>   About the new compatible string:
>     Orion was chosen for the SoC variant for the same reason as in
>     commit 5f79c651e81e ("arm: mvebu: use global interrupts for GPIOs on
>     Armada XP").
>     The "pwm" property remains optional for the new compatible string so
>     the compatiple string "marvell,armada-370-xp-gpio" can be used by
>     all and not just the first two GPIO chips. A property to select "Set
>     A" / "Set B" registers could be invented though.
> 
> ---
> 
> Pending:
>   * Needs ACK from Thierry Reding to be merged via linux-gpio tree by Linus
>     Walleij. (fine with the general approach, requested changes which
>     should have been taken care of now)

As I said elsewhere, I haven't seen an Acked-by on the binding changes,
so that would be another pending item here.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170412/e719481c/attachment.sig>
