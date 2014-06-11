From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 11 Jun 2014 19:28:48 +0200
Subject: [PATCH 1/3] clk: exynos-audss: Keep the parent of mout_audss
 always enabled
In-Reply-To: <1402464739-19044-2-git-send-email-tushar.b@samsung.com>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
 <1402464739-19044-2-git-send-email-tushar.b@samsung.com>
Message-ID: <539891D0.8090309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tushar,

On 11.06.2014 07:32, Tushar Behera wrote:
> When the output clock of AUDSS mux is disabled, we are getting kernel
> oops while doing a clk_get() on other clocks provided by AUDSS. Though
> user manual doesn't specify this dependency, we came across this issue
> while disabling the parent of AUDSS mux clocks.

Could you provide more data about this oops? E.g. kernel log, platforms
it affects (just peach-pit or also others), test case, extra patches
applied on top of mainline (if any).

I don't like this solution, because keeping a clock always enabled is
usually not desirable and this driver is also used on other platforms
than peach-pit, so this change will affect all of them.

Best regards,
Tomasz
