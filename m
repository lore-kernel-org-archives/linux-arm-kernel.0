From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon, 15 Jul 2013 16:59:21 +0200
Subject: [PATCH v5 2/7] sound: sam9x5_wm8731: machine driver for
 at91sam9x5 wm8731 boards
In-Reply-To: <20130712114926.GE24508@sirena.org.uk>
References: <1373559359-31607-1-git-send-email-richard.genoud@gmail.com>
 <1373559359-31607-3-git-send-email-richard.genoud@gmail.com>
 <20130712114926.GE24508@sirena.org.uk>
Message-ID: <CACQ1gAiJ8ww-gYfcUsux00DmpWUpfqyzzqfxZjWZSaObgsz29g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/12 Mark Brown <broonie@kernel.org>:
> On Thu, Jul 11, 2013 at 06:15:54PM +0200, Richard Genoud wrote:
>> From: Nicolas Ferre <nicolas.ferre@atmel.com>
>>
>> Description of the Asoc machine driver for an at91sam9x5 based board
>
> ASoC.
>
>> +sam9x5 pins:
>> + * LOUT
>> + * ROUT
>> + * LHPOUT
>> + * RHPOUT
>> + * LLINEIN
>> + * RLINEIN
>> + * MICIN
>
> These aren't pins on the CPU, they're pins on the CODEC, and you should
> be adding this to the binding document for the CODEC and referring to
> that rather than having them in each individual binding document.  This
> also helps if any new variants are added (not that this is likely for
> the WM8731).
ok, I'll move that

>
>> +static struct sam9x5_drvdata sam9x5_priv;
>
> Why is this a global static?
>
>> +     ret = snd_soc_register_card(&snd_soc_sam9x5);
>> +     if (ret) {
>> +             dev_err(&pdev->dev,
>> +                     "ASoC: Platform device allocation failed\n");
>> +             goto out_put_audio;
>> +     }
>
>> +     platform_set_drvdata(pdev, &snd_soc_sam9x5);
>
> It should be being dynamically allocated and retrieved as driver data
> when needed.
ok.

Thanks !


-- 
for me, ck means con kolivas and not calvin klein... does it mean I'm a geek ?
