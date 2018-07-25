From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 25 Jul 2018 16:48:32 -0700
Subject: [PATCH 1/3] clk: s2mps11: Fix matching when built as module and
 DT node contains compatible
In-Reply-To: <20180725155517.4872-2-krzk@kernel.org>
References: <20180725155517.4872-1-krzk@kernel.org>
 <20180725155517.4872-2-krzk@kernel.org>
Message-ID: <153256251231.48062.2127272830110571402@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Krzysztof Kozlowski (2018-07-25 08:55:15)
> When driver is built as module and DT node contains clocks compatible
> (e.g. "samsung,s2mps11-clk"), the module will not be autoloaded because
> module aliases won't match.
> 
> The modalias from uevent: of:NclocksT<NULL>Csamsung,s2mps11-clk
> The modalias from driver: platform:s2mps11-clk
> 
> The devices are instantiated by parent's MFD.  However both Device Tree
> bindings and parent define the compatible for clocks devices.  In case
> of module matching this DT compatible will be used.
> 
> The issue will not happen if this is built-in (no need for module
> matching) or when clocks DT node does not contain compatible (not
> correct from bindings perspective but working for driver).
> 
> Note when backporting to stable kernels: adjust the list of device ID
> entries.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 53c31b3437a6 ("mfd: sec-core: Add of_compatible strings for clock MFD cells")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
