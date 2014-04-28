From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 28 Apr 2014 09:10:36 +0200
Subject: [PATCH 5/6] ARM: AM43xx: clk: Change the cpts ref clock source
 to dpll_core_m5 clk
In-Reply-To: <1398658225-25873-6-git-send-email-george.cherian@ti.com>
References: <1398658225-25873-1-git-send-email-george.cherian@ti.com>
 <1398658225-25873-6-git-send-email-george.cherian@ti.com>
Message-ID: <20140428071034.GB4380@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 09:40:24AM +0530, George Cherian wrote:
> cpsw_cpts_rft_clk has got the choice of 3 clocksources
>  -dpll_core_m4_ck
>  -dpll_core_m5_ck
>  -dpll_disp_m2_ck
> 
> By default dpll_core_m4_ck is selected, witn this as clock
> source the CPTS doesnot work properly. It gives clockcheck errors
> while running PTP.
> 
>  clockcheck: clock jumped backward or running slower than expected!

It is strange that I have never seen this error, since I have often
tested linuxptp on a beagle bone white.

Can you please explain why this clock doesn't work correctly?

> By selecting dpll_core_m5_ck as the clocksource fixes this issue.
> In AM335x dpll_core_m5_ck is the default clocksource.

The choice of clock source in the CPTS driver originally came from
TI. It would be nice to know why that was the wrong choice.

Thanks,
Richard
