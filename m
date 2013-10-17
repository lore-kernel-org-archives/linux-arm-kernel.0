From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 17 Oct 2013 09:45:39 -0400
Subject: [PATCH 1/2] Revert "ARM: OMAP4+: CPUidle: Deprecate use of
 omap4_mpuss_read_prev_context_state()"
In-Reply-To: <525FACB7.9000903@ti.com>
References: <1382000776-15897-2-git-send-email-grygorii.strashko@ti.com>
 <525FACB7.9000903@ti.com>
Message-ID: <525FEA03.50407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 October 2013 05:24 AM, Grygorii Strashko wrote:
> The same workaround as ff999b8a0983ee15668394ed49e38d3568fc6859
> "ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX GIC control register change."
> need to be applied not only when system is booting, but when MPU hits OSWR state through CPUIdle too.
> 
> Unfortunately, commit "ARM: OMAP4+: CPUidle: Deprecate use of
> omap4_mpuss_read_prev_context_state()" prevents us from implementing workaround
> for this ROM code bug, because it should be applied only (and only)
> when MPU really hits OSWR and its was lost context.
> 
> Hence revert commit e7457253494fff660a72bc0cedeee97491ccd173
> "ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()".
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Reported-and-Tested-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
NAK.. Lets not add this which will make the code
movement to drivers/idle difficult. This can be handled..
See comments on 2/2.

Regards,
Santosh
