From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 2 Apr 2012 17:37:35 +0800
Subject: [PATCH V3 2/4] Input: pxa27x_keypad bug fix for direct_key_mask
In-Reply-To: <1333246084-14110-2-git-send-email-chao.xie@marvell.com>
References: <1333246084-14110-1-git-send-email-chao.xie@marvell.com>
 <1333246084-14110-2-git-send-email-chao.xie@marvell.com>
Message-ID: <CAN1soZzHivmGNX+T_OOfj0MOSqO_aT7q4OfHau4z-bWAC8EvuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 1, 2012 at 10:08 AM, Chao Xie <chao.xie@marvell.com> wrote:
> When direcct_key_num is 0, the mask should be 0.
> When direcct_key_num is 1, the mask should be 0b1.
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
> ?drivers/input/keyboard/pxa27x_keypad.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
> index b07771e..5d71720 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -383,7 +383,7 @@ static void pxa27x_keypad_config(struct pxa27x_keypad *keypad)
> ? ? ? ?if (pdata->direct_key_num > direct_key_num)
> ? ? ? ? ? ? ? ?direct_key_num = pdata->direct_key_num;
>
> - ? ? ? keypad->direct_key_mask = ((2 << direct_key_num) - 1) & ~mask;
> + ? ? ? keypad->direct_key_mask = ((1 << direct_key_num) - 1) & ~mask;
>
> ? ? ? ?/* enable direct key */
> ? ? ? ?if (direct_key_num)
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Loop Dmitry
