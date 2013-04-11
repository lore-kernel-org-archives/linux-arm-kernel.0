From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Wed, 10 Apr 2013 21:07:21 -0300
Subject: [PATCH v2 3/3] clk: sunxi: Unify oscillator clock
In-Reply-To: <1365631378-16103-4-git-send-email-mturquette@linaro.org>
References: <1365515284-32061-2-git-send-email-emilio@elopez.com.ar>
 <1365631378-16103-1-git-send-email-mturquette@linaro.org>
 <1365631378-16103-4-git-send-email-mturquette@linaro.org>
Message-ID: <5165FEB9.9080906@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

El 10/04/13 19:02, Mike Turquette escribi?:
> From: Emilio L?pez <emilio@elopez.com.ar>
> 
> This commit uses the new fixed-rate support on the composite clock to
> unify osc24M_fixed and osc24M clocks, so it matches the actual hardware.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> [mturquette at linaro.org: replace clk_register_gatable_osc with a call to
> clk_register_composite]
> ---
> Emilio,
> 
> I haven't been able to test these changes at run-time.  Can you see if
> they are valid for solving your issue on sunxi?

I tested the three patches you sent + 3/3 from the original series which
is the DT part.

$ git log --oneline -n 4
b63f51e ARM: sunxi: unify osc24M_fixed and osc24M
7f86473 clk: sunxi: Unify oscillator clock
78c8aaf clk: composite: allow fixed rates & fixed dividers
2d52a44 clk: composite: rename 'div' references to 'rate'

It seems to be working fine as far as I can tell, so

Tested-by: Emilio L?pez <emilio@elopez.com.ar>

Thanks,

Emilio
