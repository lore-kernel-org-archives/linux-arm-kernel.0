From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 28 Mar 2012 22:04:05 +0400
Subject: [PATCH 4/4] Input: pxa27x_keypad add choice to set direct_key_mask
In-Reply-To: <1332911324-9840-4-git-send-email-chao.xie@marvell.com>
References: <1332911324-9840-1-git-send-email-chao.xie@marvell.com>
 <1332911324-9840-4-git-send-email-chao.xie@marvell.com>
Message-ID: <4F735295.2010604@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/28/2012 09:08 AM, Chao Xie wrote:

> Direct keys usage may not start from KP_DKIN0, add a msk option
> to configure the specifics for platforms that can skip some keys.

> Signed-off-by: Chao Xie<chao.xie@marvell.com>
[...]

> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
> index b41ebda..661892b 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -391,7 +391,12 @@ static void pxa27x_keypad_config(struct pxa27x_keypad *keypad)
>   	if (pdata->direct_key_num>  direct_key_num)
>   		direct_key_num = pdata->direct_key_num;
>
> -	keypad->direct_key_mask = ((1<<  direct_key_num) - 1)&  ~mask;
> +	/* Direct keys usage may not start from KP_DKIN0, check the platfrom
> +	 * msk data to config the specific */

    The preferred multi-line comment style is not this one. You got it right in 
the previous patch. :-)

WBR, Sergei
