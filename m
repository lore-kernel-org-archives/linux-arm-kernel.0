From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 22 Aug 2013 16:20:06 -0600
Subject: [PATCHv4 2/4] arm: dts: Change dw-apb-timer-osc and
 dw-apb-timer-sp to just dw-apb-timer
In-Reply-To: <1377189026-16656-2-git-send-email-dinguyen@altera.com>
References: <1377189026-16656-1-git-send-email-dinguyen@altera.com>
 <1377189026-16656-2-git-send-email-dinguyen@altera.com>
Message-ID: <52168E96.3020702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2013 10:30 AM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> "dw-apb-timer-osc" and "dw-apb-timer-sp" are the same implementation of the
> DW APB timer, just fed by different clocks. Thus, deprecate both
> "dw-apb-timer-osc" and "dw-apb-timer-sp" in lieu of "dw-apb-timer".

The binding change looks reasonable to me.

The *.dtsi change will cause the new DT not to work with older kernels
that don't support the new compatible values. Perhaps you're fine with that?

I assume that the driver has already been updated to support the new
values, and that the driver change is guaranteed to be merged before
this change? Otherwise, git bisect will be broken for a while.
