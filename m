From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Aug 2013 16:48:21 -0600
Subject: [PATCHv2 1/2] ARM: dts: Change dw-apb-timer-osc and
 dw-apb-timer-sp to just dw-apb-timer
In-Reply-To: <1376522956-14960-1-git-send-email-dinguyen@altera.com>
References: <1376522956-14960-1-git-send-email-dinguyen@altera.com>
Message-ID: <520EAC35.5000804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2013 05:29 PM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> "dw-apb-timer-osc" and "dw-apb-timer-sp" are the same implementation of the
> DW APB timer, just fed by different clocks. Thus, deprecate both
> "dw-apb-timer-osc" and "dw-apb-timer-sp" in lieu of "dw-apb-timer",
> 
> Clean up the timer entries for socfpga by removing timer<n> and set the
> correct clocks for the timers.

Hmm. That sounds like a separate patch. Cleanup isn't the same as adding
new DT compatible values...

> diff --git a/Documentation/devicetree/bindings/rtc/dw-apb.txt b/Documentation/devicetree/bindings/rtc/dw-apb.txt

>  Required properties:
> -- compatible: "snps,dw-apb-timer-sp" or "snps,dw-apb-timer-osc"
> +- compatible: "snps,dw-apb-timer-sp" or "snps,dw-apb-timer-osc" <DEPRECATED>
> +- compatible: "snps,dw-apb-timer"

It's slightly unclear whether "snps,dw-apb-timer-sp" is deprecated.
Also, listing the non-deprecated values first would be a good hint to
people which they should use. How about:

compatible: One of:
	"snps,dw-apb-timer"
	"snps,dw-apb-timer-sp" <DEPRECATED>
	"snps,dw-apb-timer-osc" <DEPRECATED>
