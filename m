From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Fri, 17 Jun 2016 09:03:36 -0700
Subject: [PATCH V2 45/63] clocksource/drivers/timer-keystone: Convert init
 function to return error
In-Reply-To: <1466112442-31105-46-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-46-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <d8c2943e-8181-c86b-49e7-1a3f473e6407@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/16/2016 2:27 PM, Daniel Lezcano wrote:
> The init functions do not return any error. They behave as the following:
>
>   - panic, thus leading to a kernel crash while another timer may work and
>        make the system boot up correctly
>
>   or
>
>   - print an error and let the caller unaware if the state of the system
>
> Change that by converting the init functions to return an error conforming
> to the CLOCKSOURCE_OF_RET prototype.
>
> Proper error handling (rollback, errno value) will be changed later case
> by case, thus this change just return back an error or success in the init
> function.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/timer-keystone.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
