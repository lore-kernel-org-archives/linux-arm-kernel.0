From: dianders@chromium.org (Doug Anderson)
Date: Thu, 5 May 2016 15:55:54 -0700
Subject: [PATCH v7 3/9] i2c: rk3x: Remove redundant rk3x_i2c_clean_ipd()
In-Reply-To: <1462371194-5809-4-git-send-email-david.wu@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
 <1462371194-5809-4-git-send-email-david.wu@rock-chips.com>
Message-ID: <CAD=FV=XpS4UYR5ORXUOGJXPXBr_Tpc6r87+Tm83KE654ZbkdzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

On Wed, May 4, 2016 at 7:13 AM, David Wu <david.wu@rock-chips.com> wrote:
> Call rk3x_i2c_setup() before rk3x_i2c_start()
> and the last thing in setup was to clean the IPD,
> so no reason to do it at the beginning of start.
>
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
> Change in v7:
> - none
>
>  drivers/i2c/busses/i2c-rk3x.c | 1 -
>  1 file changed, 1 deletion(-)

Looks great.  Thanks for splitting this out from other patches--makes
it much more obvious what's happening!  :)

IMHO this can be applied any time independent of any earlier patches.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
