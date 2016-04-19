From: van.freenix@gmail.com (Peng Fan)
Date: Tue, 19 Apr 2016 21:39:14 +0800
Subject: [PATCH 3/3] nvmem: imx-ocotp: handling clock
In-Reply-To: <CAOMZO5CBeMn_m79vUzmk21nA1s+COiFoqfywXUJ2mOS38wBAdg@mail.gmail.com>
References: <1461054788-339-1-git-send-email-van.freenix@gmail.com>
 <1461054788-339-3-git-send-email-van.freenix@gmail.com>
 <CAOMZO5CBeMn_m79vUzmk21nA1s+COiFoqfywXUJ2mOS38wBAdg@mail.gmail.com>
Message-ID: <20160419133911.GA6823@linux-vaa1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,
On Tue, Apr 19, 2016 at 07:42:17AM -0300, Fabio Estevam wrote:
>Hi Peng,
>
>On Tue, Apr 19, 2016 at 5:33 AM, Peng Fan <van.freenix@gmail.com> wrote:
>
>> @@ -46,11 +48,15 @@ static int imx_ocotp_read(void *context, const void *reg, size_t reg_size,
>>         if (count > (priv->nregs - index))
>>                 count = priv->nregs - index;
>>
>> +       clk_prepare_enable(priv->clk);
>
>clk_prepare_enable() may fail, so you should better check its return
>value and propagate it in the case of error.

Thanks for correcting me. Will fix it in V2.

Thanks,
Peng

-- 
