From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 7 May 2013 10:36:02 +0100
Subject: dw_apb_timer_of.c: remove parts that were picoxcell-specific
In-Reply-To: <20130426214313.GB24891@amd.pavel.ucw.cz>
References: <20130426121433.GA16249@amd.pavel.ucw.cz>
 <20130426124128.GB6946@page>
 <20130426213723.GA24891@amd.pavel.ucw.cz>
 <20130426214313.GB24891@amd.pavel.ucw.cz>
Message-ID: <20130507093602.GA30902@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

Apologies for the delay, but this looks good to me.

On Fri, Apr 26, 2013 at 11:43:14PM +0200, Pavel Machek wrote:
> It seems we made a mistake when creating dw_apb_timer_of.c:
> picoxcell sched_clock had parts that were not related to
> dw_apb_timer, yet we moved them to dw_apb_timer_of, and tried to
> use them on socfpga.
> 
> This results in system where user/system time is not measured
> properly, as demonstrated by
>     
>     time dd if=/dev/urandom of=/dev/zero bs=100000 count=100
>     
> So this patch switches sched_clock to hardware that exists on both
> platforms, and adds missing of_node_put() in dw_apb_timer_init().
>     
> Signed-off-by: Pavel Machek <pavel@denx.de>

Acked-by: Jamie Iles <jamie@jamieiles.com>
