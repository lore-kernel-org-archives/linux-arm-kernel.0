From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 11 Jun 2014 09:50:38 -0700
Subject: [PATCH 1/3] clk: exynos-audss: Keep the parent of mout_audss
 always enabled
In-Reply-To: <1402464739-19044-2-git-send-email-tushar.b@samsung.com> (Tushar
 Behera's message of "Wed, 11 Jun 2014 11:02:17 +0530")
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
 <1402464739-19044-2-git-send-email-tushar.b@samsung.com>
Message-ID: <7ha99jjspt.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tushar Behera <tushar.b@samsung.com> writes:

> When the output clock of AUDSS mux is disabled, we are getting kernel
> oops while doing a clk_get() on other clocks provided by AUDSS. 
>
> Though user manual doesn't specify this dependency, we came across
> this issue while disabling the parent of AUDSS mux clocks.
>
> Keeping the parents of AUDSS mux always enabled fixes this issue.

While this patch works (and fixes the boot problem for me), it seems
like it's papering over the real problem.

Seems like the right fix is actually modelling the clocks properly so
that enabling a child clock ensures that the parent is also enabled.

Kevin
