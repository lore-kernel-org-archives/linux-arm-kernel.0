From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Sep 2016 07:32:37 +0200
Subject: [PATCH v2] pwm: berlin: Add PM support
In-Reply-To: <1448444485-4857-1-git-send-email-jszhang@marvell.com>
References: <1448444485-4857-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160905053237.GB3532@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 05:41:25PM +0800, Jisheng Zhang wrote:
> This patch adds S2R support for berlin pwm driver.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
> Since v1:
>  - implement .request and .free hooks, allocate/free the channel in
>    berlin_pwm_request/berlin_pwm_free. Then use pwm_get_chip_data in
>    suspend/resume implementation.
>  - s/int/unsigned int
>  - check return value of clk_prepare_enable
>  - remoev BERLIN_PWM_PM_OPS macro
>  drivers/pwm/pwm-berlin.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 89 insertions(+), 1 deletion(-)

Sorry, I had completely missed this. Applied now, with some minor
stylistic changes.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/61dd2365/attachment.sig>
