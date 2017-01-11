From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 11 Jan 2017 11:52:36 +0100
Subject: [PATCH] rtc: armada38x: make struct rtc_class_ops const
In-Reply-To: <E1cRFxi-00083n-FY@rmk-PC.armlinux.org.uk>
References: <E1cRFxi-00083n-FY@rmk-PC.armlinux.org.uk>
Message-ID: <20170111105236.5ucue6ybqvfulese@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/2017 at 10:16:58 +0000, Russell King wrote :
> Armada38x wants to modify its rtc_class_ops to remove the interrupt
> handling when there is no usable interrupt, but this means we leave
> function pointers in writable memory.
> 
> Since rtc_class_ops is small, arrange to have two instances, one for
> when we have interrupts, and one for when we have none, both marked
> const.  This allows the compiler to place them in read-only memory,
> which is better than placing them in __ro_after_init.
> 
> Thanks to Bhumika Goyal <bhumirks@gmail.com> for pointing out that
> the structure was writable and submitting a patch to add
> __ro_after_init.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> As the thread has gone quiet, I'm submitting the patch I sent within that
> thread.  No one appears to have raised an objection to it (other than what
> appears to be a misunderstanding.)
> 
>  drivers/rtc/rtc-armada38x.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
