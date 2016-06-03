From: briannorris@chromium.org (Brian Norris)
Date: Fri, 3 Jun 2016 13:51:17 -0700
Subject: [PATCH 11/14] regulator: pwm: properly initialize the ->state
 field
In-Reply-To: <1464942192-25967-12-git-send-email-boris.brezillon@free-electrons.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-12-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160603205117.GI124478@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 10:23:09AM +0200, Boris Brezillon wrote:
> The ->state field is currently initialized to 0, thus referencing the
> voltage selector at index 0, which might not reflect the current voltage
> value.
> If possible, retrieve the current voltage selector from the PWM state, else
> return -EINVAL.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> Heiko, Mark,
> 
> I know you already added your Tested-by/Acked-by tags on this patch
> but this version has slightly change and is now making use of the
> pwm_get_relative_duty_cycle() helper instead of manually converting
> the absolute duty_cycle value into a relative one.
> ---
>  drivers/regulator/pwm-regulator.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Tested-by: Brian Norris <briannorris@chromium.org>
