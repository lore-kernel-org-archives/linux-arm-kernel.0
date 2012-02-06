From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 06 Feb 2012 22:22:49 +0100
Subject: [PATCH v2 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <1328541585-24642-3-git-send-email-thierry.reding@avionic-design.de>
References: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
 <1328541585-24642-3-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4F3044A9.8000202@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2012 04:19 PM, Thierry Reding wrote:
> This commit modifies the PWM core to support multiple PWMs per struct
> pwm_chip.

I think you should mention what motivates this change.

> It achieves this in a similar way to how gpiolib works, by
> allowing PWM ranges to be requested dynamically (pwm_chip.base == -1) or
> starting at a given offset (pwm_chip.base >= 0).

If we've learned one thing from gpiolib, I think it is that using a global
index to identify a resource was a bad idea.

> A chip specifies how
> many PWMs it controls using the npwm member. Each of the functions in
> the pwm_ops structure gets an additional argument that specified the PWM
> number (it can be converted to a per-chip index by subtracting the
> chip's base).
> 
> The total maximum number of PWM devices is currently fixed to 64, but
> can easily be made configurable via Kconfig.

The code says 1024.

> 
> The patch is incomplete in that it doesn't convert any existing drivers
> that are now broken.
