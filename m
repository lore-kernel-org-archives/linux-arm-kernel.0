From: janakiram.sistla@gmail.com (Janakiram Sistla)
Date: Fri, 19 Nov 2010 11:09:06 -0800
Subject: [PATCH v4 2/2] msm: gpio: Add irq support to v2 gpiolib.
In-Reply-To: <alpine.DEB.2.00.1011191053040.10560@gbean-linux.qualcomm.com>
References: <1290109970-26752-1-git-send-email-gbean@codeaurora.org>
	<1290109970-26752-2-git-send-email-gbean@codeaurora.org>
	<AANLkTimTsyhjHJZggFO31C-2RswpmKWn-V4pGEiQ3+_2@mail.gmail.com>
	<alpine.DEB.2.00.1011181229380.26784@gbean-linux.qualcomm.com>
	<AANLkTi=p02P=-JQ9+FynFyM1yxrAh3utKTD2uzqhnLxK@mail.gmail.com>
	<alpine.DEB.2.00.1011181256470.29924@gbean-linux.qualcomm.com>
	<AANLkTiknYmWOmiFXGp6h2dT==aMuGs3BtXi82b6Vdq5i@mail.gmail.com>
	<alpine.DEB.2.00.1011191035210.10052@gbean-linux.qualcomm.com>
	<AANLkTiknSudbo_j+nqBqmds49CWyqXf0jpvz+DTYH-zg@mail.gmail.com>
	<alpine.DEB.2.00.1011191053040.10560@gbean-linux.qualcomm.com>
Message-ID: <AANLkTi=VGx1xR3f7_8-cMQAmaz6PQ-t=Xubk_Jtp911V@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 19, 2010 at 11:00 AM, Gregory Bean <gbean@codeaurora.org> wrote:
>>>>> Targets with the v2 block define CONFIG_MSM_V2_TLMM.
>>>>
>>>> So in that case we can name ?it as gpio-tlmm.c ??
>>>
>>> No, not and have things be any clearer.
>>>
>>> All MSM chips have a TLMM block. ?The older chips have
>>> version 1 (v1) of the TLMM block. ?The newer chips have v2.
>>
>> I think that we should differentiate the new gpio infrastructure with
>> appropriate naming that makes the diff between v1 and v2
>
> What do you suggest? ?All MSM SoCs have a TLMM block. ?The block itself
> carries no model or revision name, and is not tied specifically to any
> particular SoC, except for the fact that the second generation of this block
> happened to appear at the same time as the MSM8x60.
>
> gpio.c is already in wide use for v1 systems, and is well-establised
> in the android mainlines. ?Changing without extremely good cause would not
> go pleasantly.
>
> Since gpio.c is v1, we used gpio-v2.c for v2.
Greg, i agree your point ,but i think v2 differs from v1 with a new
features distinguished.Also there might be a intention behind going
for v2 that might resolve some hardware erratas in v1.
what if again a new generation comes then we will name it gpio-v3.c ??
>
> --
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
