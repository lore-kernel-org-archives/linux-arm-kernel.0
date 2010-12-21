From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 21 Dec 2010 07:26:47 -0200
Subject: [PATCH 2/2] ARM i.MX53: Make MX53 EVK bootable
In-Reply-To: <1292902651-26636-2-git-send-email-yong.shen@freescale.com>
References: <1292902651-26636-1-git-send-email-yong.shen@freescale.com>
	<1292902651-26636-2-git-send-email-yong.shen@freescale.com>
Message-ID: <AANLkTinq_kZBC3SDUhuSZCzeqVbqNHJpo3J1HgCcLfQS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

On Tue, Dec 21, 2010 at 1:37 AM,  <yong.shen@freescale.com> wrote:
...
> +
> +static void __init mx53_evk_timer_init(void)
> +{
> + ? ? ? mx53_clocks_init(32768, 24000000, 22579200, 24576000);
> +}

The 24.576MHz clock is not populated on MX53EVK. so this should be:

mx53_clocks_init(32768, 24000000, 22579200, 0);

Regards,

Fabio Estevam
