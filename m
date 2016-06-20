From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 20 Jun 2016 13:33:46 +0200
Subject: [PATCH V2 08/63] clocksource/drivers/st_lpc: Convert init
 function to return error
In-Reply-To: <1466112442-31105-9-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-9-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <5767D49A.4090507@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/16/2016 11:26 PM, Daniel Lezcano wrote:
> The init functions do not return any error. They behave as the following:
>
>   - panic, thus leading to a kernel crash while another timer may work and
>     make the system boot up correctly
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
>   drivers/clocksource/clksrc_st_lpc.c | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
