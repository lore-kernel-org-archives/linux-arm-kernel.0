From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 20 Jun 2016 14:07:55 +0200
Subject: [PATCH 1/7] reset: Reorder inline reset_control_get*() wrappers
In-Reply-To: <20160606155655.10860-2-lee.jones@linaro.org>
References: <20160606155655.10860-1-lee.jones@linaro.org>
 <20160606155655.10860-2-lee.jones@linaro.org>
Message-ID: <1466424475.6070.43.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 06.06.2016, 16:56 +0100 schrieb Lee Jones:
> We're about to split the current API into two, where consumers will
> be forced to be explicit when requesting reset lines.  The choice
> will be to either the call the *_exclusive or *_shared variant
> depending on whether they can actually tolorate not being asserted
> when that request is made.
> 
> The new API will look like this once reorded and complete:
> 
>   reset_control_get_exclusive()
>   reset_control_get_shared()
>   reset_control_get_optional_exclusive()
>   reset_control_get_optional_shared()
>   of_reset_control_get_exclusive()
>   of_reset_control_get_shared()
>   of_reset_control_get_exclusive_by_index()
>   of_reset_control_get_shared_by_index()
>   devm_reset_control_get_exclusive()
>   devm_reset_control_get_shared()
>   devm_reset_control_get_optional_exclusive()
>   devm_reset_control_get_optional_shared()
>   devm_reset_control_get_exclusive_by_index()
>   devm_reset_control_get_shared_by_index()
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I have applied patches 1-5 to my reset/next branch.

regards
Philipp
