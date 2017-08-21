From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Aug 2017 09:58:01 +0200
Subject: [PATCH v3 5/6] pwm: mediatek: add PWM_CLK_DIV_MAX
In-Reply-To: <1498802721-32455-6-git-send-email-zhi.mao@mediatek.com>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
 <1498802721-32455-6-git-send-email-zhi.mao@mediatek.com>
Message-ID: <20170821075801.GO18996@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 02:05:20PM +0800, Zhi Mao wrote:
> 1. Replace "7" with "PWM_CLK_DIV_MAX" in function:mtk_pwm_config()
> to improve the code readablity.
> 2. add pwm clk disable in function:mtk_pwm_config()
> for error parameter checking case.
> 
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Same comment as before. You've got two logical, unrelated changes in
this one commit. In this case you're mixing a cosmetic change with an
actual bug fix. And to make things worse, the commit subject mentions
only the cosmetic change, while the more important changes is only
described in a drive-by fashion.

You get another free pass this time, but please be more conscious about
these things in the future.

I've applied this to for-4.14/drivers with the following commit message:

--- >8 ---
pwm: mediatek: Disable clock on PWM configuration failure

Make sure to disable the PWM clock if the PWM cannot be configured due
to the clock divider exceeding the maximum value.

While at it, replace the hardcoded maximum clock divider with a defined
constant to improve code readability.

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
Acked-by: John Crispin <john@phrozen.org>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
--- 8< ---

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/83b70fd6/attachment-0001.sig>
