From: patrice.chotard@st.com (Patrice Chotard)
Date: Tue, 17 May 2016 09:43:18 +0200
Subject: [PATCH] pinctrl: stm32: fix debugfs format string
In-Reply-To: <1463147643-568615-1-git-send-email-arnd@arndb.de>
References: <1463147643-568615-1-git-send-email-arnd@arndb.de>
Message-ID: <573ACB96.6030808@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

I have already send a fix for this on the mailing list on 12th may 
([PATCH 0/2] pinctrl: stm32: .pin_config_dbg_show fixes).
I don't know if Linus will merged it on his pinctrl branch.

Sorry

Patrice

On 05/13/2016 03:53 PM, Arnd Bergmann wrote:
> The newly added stm32_pconf_dbg_show function has an incorrect format
> string that does not match the arguments, as reported by the gcc warning:
>
> drivers/pinctrl/stm32/pinctrl-stm32.c: In function 'stm32_pconf_dbg_show':
> drivers/pinctrl/stm32/pinctrl-stm32.c:797:17: error: too many arguments for format [-Werror=format-extra-args]
>
> This changes the format string in a way that gets rid of the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 3beed93c1617 ("pinctrl: stm32: Implement .pin_config_dbg_show()")
> ---
> I could not find a documentation for the debugfs format, so no
> idea if this is the intended format.
> ---
>   drivers/pinctrl/stm32/pinctrl-stm32.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
> index e51c1cf5270b..4ffbe9551299 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
> @@ -794,7 +794,7 @@ static void stm32_pconf_dbg_show(struct pinctrl_dev *pctldev,
>   	case 2:
>   		drive = stm32_pconf_get_driving(bank, offset);
>   		speed = stm32_pconf_get_speed(bank, offset);
> -		seq_printf(s, "%d - %s -%s", alt,
> +		seq_printf(s, "%d - %s - %s - %s %s ", alt,
>   			   drive ? "open drain" : "push pull",
>   			   biasing[bias],
>   			   speeds[speed], "speed");
