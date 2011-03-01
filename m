From: javier.martin@vista-silicon.com (javier Martin)
Date: Tue, 1 Mar 2011 08:59:23 +0100
Subject: [PATCH 1/4] ASoC: Add TI tlv320aic32x4 codec support.
In-Reply-To: <20110228150014.GI13869@opensource.wolfsonmicro.com>
References: <1298641370-17461-1-git-send-email-javier.martin@vista-silicon.com>
	<20110228150014.GI13869@opensource.wolfsonmicro.com>
Message-ID: <AANLkTinjj8rZS_Y9qiHbrU2nAYSXTikTNtyU71Bk7UqL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
thank you for your review. I will try to solve every issue you pointed out.

Regarding non-default configurations:

>> +static const struct aic32x4_configs aic32x4_reg_init[] = {
>> + ? ? {AIC32X4_PWRCFG, AIC32X4_AVDDWEAKDISABLE},
>
> What are these "aic32x4_configs" all about? ?They look like you're
> setting non-default configurations...

This tlv320aic32x4 codec is kind of a huge monster; it has more than
200 registers which provide more flexibility than it is needed.
For example, BCLK and MCLK are forced here to derive from internal PLL
which is needed for frequency calculation table to be valid. Bypassing
this PLL doesn't provide new or better functionality.
The same happens regarding DAC internal connections. I don't think
allowing the user to swap left and right channels makes sense here.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
