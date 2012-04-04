From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 4 Apr 2012 14:44:24 +0800
Subject: [PATCH v5 02/16] pwm: Allow chips to support multiple PWMs
In-Reply-To: <1332945238-14897-3-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-3-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120404064422.GC7264@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 04:33:44PM +0200, Thierry Reding wrote:
> Many PWM controllers provide access to more than a single PWM output and
> may even share some resource among them. Allowing a PWM chip to provide
> multiple PWM devices enables better sharing of those resources. As a
> side-effect this change allows easy integration with the device tree
> where a given PWM can be looked up based on the PWM chip's phandle and a
> corresponding index.
> 
> This commit modifies the PWM core to support multiple PWMs per struct
> pwm_chip. It achieves this in a similar way to how gpiolib works, by
> allowing PWM ranges to be requested dynamically (pwm_chip.base == -1) or
> starting at a given offset (pwm_chip.base >= 0). A chip specifies how
> many PWMs it controls using the npwm member. Each of the functions in
> the pwm_ops structure gets an additional argument that specified the PWM
> number (it can be converted to a per-chip index by subtracting the
> chip's base).
> 
> The total maximum number of PWM devices is currently fixed to 1024 while
> the data is actually stored in a radix tree, thus saving resources if
> not all of them are used.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
