From: per.forlin@linaro.org (Per Forlin)
Date: Wed, 22 Jun 2011 11:38:41 +0200
Subject: [PATCH v7 02/11] omap_hsmmc: add support for pre_req and post_req
In-Reply-To: <BANLkTi=GT=1u0YEtUaJre24BOhRyDNGUSg@mail.gmail.com>
References: <1308699521-20556-1-git-send-email-per.forlin@linaro.org>
	<1308699521-20556-3-git-send-email-per.forlin@linaro.org>
	<BANLkTikqeKg=Mr9BxVYL7x=9k_jzGeLnQQ@mail.gmail.com>
	<BANLkTi=GT=1u0YEtUaJre24BOhRyDNGUSg@mail.gmail.com>
Message-ID: <BANLkTi=udZv3g-jB+FBWyaXqhQie3B2EaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 June 2011 11:31, Per Forlin <per.forlin@linaro.org> wrote:
> On 22 June 2011 10:51, Nickolay Nickolaev <nicknickolaev@gmail.com> wrote:
>> Hello,
>>
>> this one's causing me compilation trouble troubles when CONFIG_DMA_ENGINE is
>> not defined.
>>
> I don't see this issue when I compile the kernel for a Pandaboard
> without CONFIG_DMA_ENGINE being set. Could you please clarify or show
> me your build log?
> I don't see how host->next_data.cookie is connected to DMA_ENGINE.
>
I think you are referring to the mmci-patch. I'll fix the issue in mmci.

>> On Wed, Jun 22, 2011 at 2:38 AM, Per Forlin <per.forlin@linaro.org> wrote:
>>>
>>> @@ -2077,6 +2155,7 @@ static int __init omap_hsmmc_probe(struct
>>> platform_device *pdev)
>>> ? ? ? ?host->mapbase ? = res->start;
>>> ? ? ? ?host->base ? ? ?= ioremap(host->mapbase, SZ_4K);
>>> ? ? ? ?host->power_mode = MMC_POWER_OFF;
>>> + ? ? ? host->next_data.cookie = 1;
>>>
>>> ? ? ? ?platform_set_drvdata(pdev, host);
>>> ? ? ? ?INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect);
>>> --
>>> 1.7.4.1
>>>
>>>
>>
>> Maybe we can wrap it in a function as the others.
>>
>> regards,
>> Nikolay Nikolaev
>>
>
> Regards,
> Per
>
