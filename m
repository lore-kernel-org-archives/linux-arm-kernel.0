From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 11 May 2018 11:26:58 +0200
Subject: [PATCH V5 2/4] soc: mediatek: pwrap: fix cipher init setting error
In-Reply-To: <1525957319-20557-3-git-send-email-argus.lin@mediatek.com>
References: <1525957319-20557-1-git-send-email-argus.lin@mediatek.com>
 <1525957319-20557-3-git-send-email-argus.lin@mediatek.com>
Message-ID: <318abd43-a2ac-121c-8c18-dd32248a4676@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/10/2018 03:01 PM, argus.lin at mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> PWRAP_DEW_CIPHER_LOAD and PWRAP_DEW_CIPHER_START only exist at
> PMIC_mt6397 datasheet. We fix it before merge PMIC_mt6351 driver.

Please don't put info like "We fix it before merge PMIC_mt6351 driver." in the
commit message. You can see this from the git log later and it does not add any
value.

Regards,
Matthias

> 
> Fixes: 5ae48040aa47 ("soc: mediatek: PMIC wrap: add mt6323 slave support")
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index e9e054a..9a01e30 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -1080,8 +1080,6 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>  	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_SWRST], 0x0);
>  	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_KEY_SEL], 0x1);
>  	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_IV_SEL], 0x2);
> -	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_LOAD], 0x1);
> -	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_START], 0x1);
>  
>  	switch (wrp->slave->type) {
>  	case PMIC_MT6397:
> -- 
> 1.8.1.1.dirty
> 
> ************* Email Confidentiality Notice ********************
> The information contained in this e-mail message (including any 
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be 
> conveyed only to the designated recipient(s). Any use, dissemination, 
> distribution, printing, retaining or copying of this e-mail (including its 
> attachments) by unintended recipient(s) is strictly prohibited and may 
> be unlawful. If you are not an intended recipient of this e-mail, or believe 
> that you have received this e-mail in error, please notify the sender 
> immediately (by replying to this e-mail), delete any and all copies of 
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!
> 
