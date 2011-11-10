From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 10 Nov 2011 10:37:18 +0800
Subject: [RFC PATCH] Generic clock parent enumeration
In-Reply-To: <20111104175908.GA9337@glitch>
References: <20111104175908.GA9337@glitch>
Message-ID: <20111110023716.GA11045@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2011 at 06:59:08PM +0100, Domenico Andreoli wrote:
> Hi,
> 
>   here is my proposal for the enumeration of a clock parents and the
> first implementation of clk_set_parent() based on it. It depends on
> the generic-clk-v2 patchset.
> 
> The basic idea is that only the clock can provide a way to walk all
> the parent clocks that it can be attached to. This has multiple purposes:
> 
>  1. generic clock framework is able to find the best parent a given
>     clock can be attached to in order to satisfy an arbitrary requirement
>     (ie the lowest number of enabled parent clocks, energy constrains,
>     clock network tuning, etc)
Is there any use case that you have to let clk core select parent?
In my opinion, clk parent don't change frequently. most time display
driver do that, which must has ideas of clk tree topology.
> 
>  2. generic clock framework is able to check in an implementation
>     independent way if a given clock is suitable to be parent of
>     another one
Only mux clk driver needs it.

Richard
> 
>  3. the proposed implementation of the generic clk_set_parent()
> 
> 
> Signed-off-by: Domenico Andreoli <cavokz@gmail.com>
> 
