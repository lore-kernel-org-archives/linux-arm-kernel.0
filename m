From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Mon, 8 Feb 2016 22:14:18 +0200
Subject: [PATCH] ARM: OMAP2+: Fix onenand initialization to avoid
 filesystem corruption
In-Reply-To: <20160208193644.GU19432@atomide.com>
References: <linux-kernel@vger.kernel.org>
 <1454683028-4193-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160208193644.GU19432@atomide.com>
Message-ID: <56B8F71A.7090102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On  8.02.2016 21:36, Tony Lindgren wrote:
>
> OK. So probably the INT or RDY polarity made the ECC not work.
>

Well, ECC disable bit (ONENAND_SYS_CFG1_NO_ECC) was set as well, so most 
probably it was the bugger :)

> Aaro, care to dump out also the nolo configured CFG1 value from
> n8x0 and n9(50)?
>
> You can do it by adding something like this to the beginning
> of set_onenand_cfg():
>

Also, do not forget to restore HWMOD_INIT_NO_RESET in gpmc_hwmod in 
question and (maybe) revert e7b11dc7b77bfce0a351230a5feeadc1d0bba997.

Regards,
Ivo
