From: cxie4@marvell.com (Chao Xie)
Date: Thu, 29 Mar 2012 02:15:00 -0700
Subject: [PATCH 4/4] Input: pxa27x_keypad add choice to set direct_key_mask
In-Reply-To: <4F735295.2010604@mvista.com>
References: <1332911324-9840-1-git-send-email-chao.xie@marvell.com>
 <1332911324-9840-4-git-send-email-chao.xie@marvell.com>
 <4F735295.2010604@mvista.com>
Message-ID: <AAD1C6EB06EE3649B35B7E026785068D1A7474ABC7@SC-VEXCH2.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks. I will sent V2 patches.

-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov at mvista.com] 
Sent: Thursday, March 29, 2012 2:04 AM
To: Chao Xie
Cc: linux-input at vger.kernel.org; eric.y.miao at gmail.com; Haojian Zhuang; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH 4/4] Input: pxa27x_keypad add choice to set direct_key_mask

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
