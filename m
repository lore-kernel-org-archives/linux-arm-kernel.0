From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Mar 2013 14:05:25 +0100
Subject: mvebu: Device bus driver resurrection
In-Reply-To: <20130326124337.GD2454@localhost>
References: <20130326124337.GD2454@localhost>
Message-ID: <20130326140525.0167bd72@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 26 Mar 2013 09:43:38 -0300, Ezequiel Garcia wrote:

> Now that we've all agreed on a mvebu mbus driver (or a first version of it)
> I'd like to resurrect the Device Bus driver.
> 
> As far as I can remember, the last things said about this driver were:
> 
>   * The timing parameters should be in {nano,pico,etc} seconds,
>     instead of ticks.
> 
>   * Although not everyone agreed, this driver was a good thing to have
>     so we no longer depend on the bootloader setting these parameters.
>     
>   * The address decoding windows should *not* be setup by this driver,
>     but rather be described in the device tree itself.
> 
> If anyone has aditional comments, please speak your mind.
> 
> My plan is to address all of the above comments, and send a v2 soon.
> 
> However, since we do not yet describe the address windows at the device tree,
> the plan is to do window allocation/release in this devbus driver
> **only as a temporal solution**.
> 
> Once the address decoding windows are properly described in the DTS,
> we can remove that handling from the driver for good.
> 
> Does this sound sane enough?

Of course I do agree with your proposal, and I'd like to say that I'm
committed to work on a proper DT binding for the mvebu-mbus driver so
that the static windows can ultimately be defined in the Device Tree.
So what Ezequiel presents here as a temporary solution really is.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
