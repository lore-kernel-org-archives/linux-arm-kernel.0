From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 4 Mar 2016 16:17:48 +0100
Subject: [PATCH 1/4] pwm: omap-dmtimer: fix inaccurate period/duty_cycle
 calculation
In-Reply-To: <1454128014-22866-2-git-send-email-drivshin.allworx@gmail.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
 <1454128014-22866-2-git-send-email-drivshin.allworx@gmail.com>
Message-ID: <20160304151748.GD26400@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 11:26:51PM -0500, David Rivshin (Allworx) wrote:
> From: David Rivshin <drivshin@allworx.com>
> 
> Fix the calculation of load_value and match_value. Currently they
> are slightly too low, which produces a noticeably wrong PWM rate with
> sufficiently short periods (i.e. when 1/period approaches clk_rate/2).
> 
> Example:
>  clk_rate=32768Hz, period=122070ns, duty_cycle=61035ns (8192Hz/50% PWM)
>  Correct values: load = 0xfffffffc, match = 0xfffffffd
>  Current values: load = 0xfffffffa, match = 0xfffffffc
>  effective PWM: period=183105ns, duty_cycle=91553ns (5461Hz/50% PWM)
> 
> Fixes: 6604c6556db9 ("pwm: Add PWM driver for OMAP using dual-mode timers")
> Signed-off-by: David Rivshin <drivshin@allworx.com>
> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160304/411a42e6/attachment.sig>
