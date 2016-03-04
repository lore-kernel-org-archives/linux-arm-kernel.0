From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 4 Mar 2016 16:18:04 +0100
Subject: [PATCH 3/4] pwm: omap-dmtimer: round load and match values
 rather than truncate
In-Reply-To: <1454128014-22866-4-git-send-email-drivshin.allworx@gmail.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
 <1454128014-22866-4-git-send-email-drivshin.allworx@gmail.com>
Message-ID: <20160304151804.GE26400@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 11:26:53PM -0500, David Rivshin (Allworx) wrote:
> From: David Rivshin <drivshin@allworx.com>
> 
> When converting period and duty_cycle from nanoseconds to fclk cycles,
> the error introduced by the integer division can be appreciable, especially
> in the case of slow fclk or short period. Use DIV_ROUND_CLOSEST_ULL() so
> that the error is kept to +/- 0.5 clock cycles.
> 
> Fixes: 6604c6556db9 ("pwm: Add PWM driver for OMAP using dual-mode timers")
> Signed-off-by: David Rivshin <drivshin@allworx.com>
> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160304/999afb7d/attachment.sig>
