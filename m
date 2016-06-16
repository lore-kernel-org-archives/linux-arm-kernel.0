From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 16 Jun 2016 14:43:46 -0700
Subject: [PATCH V2 07/63] clocksource/drivers/cadence_ttc: Convert init
 function to return error
In-Reply-To: <1466112442-31105-8-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-8-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20160616214346.GN19175@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-06-16 at 23:26:26 +0200, Daniel Lezcano wrote:
> The init functions do not return any error. They behave as the following:
> 
>  - panic, thus leading to a kernel crash while another timer may work and
>    make the system boot up correctly
> 
>  or
> 
>  - print an error and let the caller unaware if the state of the system
> 
> Change that by converting the init functions to return an error conforming
> to the CLOCKSOURCE_OF_RET prototype.
> 
> Proper error handling (rollback, errno value) will be changed later case
> by case, thus this change just return back an error or success in the init
> function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
