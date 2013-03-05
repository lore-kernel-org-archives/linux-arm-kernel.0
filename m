From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 5 Mar 2013 17:16:25 +0530
Subject: [PATCH v4 3/5] mmc: davinci_mmc: add DT support
In-Reply-To: <A73F36158E33644199EB82C5EC81C7BC3EA484E9@DBDE01.ent.ti.com>
References: <1360909322-1858-1-git-send-email-prakash.pm@ti.com>
 <1360909322-1858-4-git-send-email-prakash.pm@ti.com> <512DF16F.50702@ti.com>
 <A73F36158E33644199EB82C5EC81C7BC3EA484E9@DBDE01.ent.ti.com>
Message-ID: <5135DB11.7080602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/5/2013 4:54 PM, Manjunathappa, Prakash wrote:

>>> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>>> +	if (!pdata) {
>>> +		dev_err(&pdev->dev, "Failed to allocate memory for struct davinci_mmc_config\n");
>>> +		goto nodata;
>>
>> devm_kzalloc() returns NULL on error so you will end up returning
>> success in this case.
>>
> 
> Returns NULL on failure, caller is checking on NULL for failures.
> 
>         pdata = mmc_parse_pdata(pdev);
>         if (pdata == NULL) {
>                 dev_err(&pdev->dev, "Can not get platform data\n");
>                 return -ENOENT;
>         }

Ha, okay. I was somehow confused into thinking this is part of probe
routine.

Thanks,
Sekhar
