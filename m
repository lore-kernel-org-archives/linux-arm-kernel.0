From: patrice.chotard@st.com (Patrice Chotard)
Date: Tue, 17 Mar 2015 09:13:52 +0100
Subject: [PATCH 27/35 linux-next] reset: sti: constify of_device_id array
In-Reply-To: <1426535685-25996-6-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-6-git-send-email-fabf@skynet.be>
Message-ID: <5507E240.2070109@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabian

On 03/16/2015 08:54 PM, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>   drivers/reset/sti/reset-stih407.c | 2 +-
>   drivers/reset/sti/reset-stih415.c | 2 +-
>   drivers/reset/sti/reset-stih416.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/reset/sti/reset-stih407.c b/drivers/reset/sti/reset-stih407.c
> index d83db5d7..e250604 100644
> --- a/drivers/reset/sti/reset-stih407.c
> +++ b/drivers/reset/sti/reset-stih407.c
> @@ -126,7 +126,7 @@ static const struct syscfg_reset_controller_data stih407_picophyreset_controller
>   	.channels = stih407_picophyresets,
>   };
>   
> -static struct of_device_id stih407_reset_match[] = {
> +static const struct of_device_id stih407_reset_match[] = {
>   	{
>   		.compatible = "st,stih407-powerdown",
>   		.data = &stih407_powerdown_controller,
> diff --git a/drivers/reset/sti/reset-stih415.c b/drivers/reset/sti/reset-stih415.c
> index 8dad603..fd84238 100644
> --- a/drivers/reset/sti/reset-stih415.c
> +++ b/drivers/reset/sti/reset-stih415.c
> @@ -89,7 +89,7 @@ static struct syscfg_reset_controller_data stih415_softreset_controller = {
>   	.channels = stih415_softresets,
>   };
>   
> -static struct of_device_id stih415_reset_match[] = {
> +static const struct of_device_id stih415_reset_match[] = {
>   	{ .compatible = "st,stih415-powerdown",
>   	  .data = &stih415_powerdown_controller, },
>   	{ .compatible = "st,stih415-softreset",
> diff --git a/drivers/reset/sti/reset-stih416.c b/drivers/reset/sti/reset-stih416.c
> index 79aed70..c7ccaed 100644
> --- a/drivers/reset/sti/reset-stih416.c
> +++ b/drivers/reset/sti/reset-stih416.c
> @@ -120,7 +120,7 @@ static struct syscfg_reset_controller_data stih416_softreset_controller = {
>   	.channels = stih416_softresets,
>   };
>   
> -static struct of_device_id stih416_reset_match[] = {
> +static const struct of_device_id stih416_reset_match[] = {
>   	{ .compatible = "st,stih416-powerdown",
>   	  .data = &stih416_powerdown_controller, },
>   	{ .compatible = "st,stih416-softreset",


Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
