From: zhengxing@rock-chips.com (zhengxing)
Date: Sat, 18 Jul 2015 12:15:13 +0800
Subject: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
In-Reply-To: <55A9CD3C.10300@rock-chips.com>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <20150717180402.GS11162@sirena.org.uk> <55A9CD3C.10300@rock-chips.com>
Message-ID: <55A9D2D1.6010206@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>> +static int snd_rk_mc_remove(struct platform_device *pdev)
>>> +{
>>> +    struct snd_soc_card *soc_card = platform_get_drvdata(pdev);
>>> +
>>> +    snd_soc_card_set_drvdata(soc_card, NULL);
>>> +    snd_soc_unregister_card(soc_card);
>>> +    platform_set_drvdata(pdev, NULL);
>> No need for any of the _set_drvdata() calls, the core does them and they
>> shouldn't make any difference anyway.
> Done. I will remove *_set_drvdata and *get_drvdata because we don't 
> need them any more.
>
Sorry, I mean just remove platform_set_drvdata(pdev, NULL);
