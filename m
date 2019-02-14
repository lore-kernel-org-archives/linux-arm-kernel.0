Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D09BC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:39:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C936222D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l2swNCYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C936222D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lGDZ1xb799hYtUp6O9e0Hvd5+viNtXgVOuhVibkVi5k=; b=l2swNCYAaVlOGA
	089/ngrOG315b8FGKnouufJ4ZgYclV9UuF8zRhPk3E54misxiG4BlYRhftVhBmAIb6vZSHdxGLhi1
	Nxczx1Nm6CM4TvvVs2J2hVOVDG+SbQ6qSVJA0TaJDY+i57Zrltcc47dpaW822LERvEjBTwpTh2NJD
	HrW6aLlpGxt4tpvhWgINiuVCte8Zy0wPFiYv2Zt+n1QCiOXVjgpXUrcyWN2HCKRVPHvA4GeIZ262z
	pLspaLZ+b29mjHTvWCHZ4uKoOR4nZoVBM2P60OBp9EjT65UHrFWeIlhcK34/LEiRzVm7ztehlFh3y
	zOmhT8o6Me86+XCb0tDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guEQt-0008HW-Mn; Thu, 14 Feb 2019 10:39:55 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guEQg-00082K-2Q
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 10:39:43 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1EAbD0a007461; Thu, 14 Feb 2019 11:39:32 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qn0jwsy2c-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 14 Feb 2019 11:39:32 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B69333A;
 Thu, 14 Feb 2019 10:39:30 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7205F4EAF;
 Thu, 14 Feb 2019 10:39:30 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb
 2019 11:39:30 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 14 Feb 2019 11:39:30 +0100
From: Olivier MOYSAN <olivier.moysan@st.com>
To: Wen Yang <yellowriver2010@hotmail.com>, Arnaud POULIQUEN
 <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Alexandre
 TORGUE" <alexandre.torgue@st.com>
Subject: Re: [PATCH] ASoC: stm32: sai: add missing put_device()
Thread-Topic: [PATCH] ASoC: stm32: sai: add missing put_device()
Thread-Index: AQHUwGP3BFaM6L9X70mSmjxl1QacOaXapgiAgAMsmOaAAT70gA==
Date: Thu, 14 Feb 2019 10:39:29 +0000
Message-ID: <c62d0064-93b4-7839-7042-47a15c78b909@st.com>
References: <HK0PR02MB36348FCAF73000463738C017B26A0@HK0PR02MB3634.apcprd02.prod.outlook.com>
 <18decbe3-5a7c-1b75-4c64-0b16fdd0efec@st.com>
 <HK0PR02MB3634F3A1A0C8BF4EEC5C3874B2660@HK0PR02MB3634.apcprd02.prod.outlook.com>
In-Reply-To: <HK0PR02MB3634F3A1A0C8BF4EEC5C3874B2660@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-ID: <8C67A01B8471844D9B1833C9434BB5A4@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-14_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_023942_401807_C68E25E6 
X-CRM114-Status: GOOD (  17.42  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Acked-by: Olivier Moysan <olivier.moysan@st.com>

On 2/13/19 3:41 PM, Wen Yang wrote:
> From: Olivier MOYSAN <olivier.moysan@st.com>
> Sent: 11 February 2019 15:09
> To: Wen Yang; Arnaud POULIQUEN; Liam Girdwood; Mark Brown; Jaroslav Kysela; Takashi Iwai; Maxime Coquelin; Alexandre TORGUE
> Cc: alsa-devel@alsa-project.org; linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ASoC: stm32: sai: add missing put_device()
> 
>> On 2/9/19 11:41 AM, Wen Yang wrote:
>>> The of_find_device_by_node() takes a reference to the underlying device
>>> structure, we should release that reference.
>>>
>>> Fixes: 7dd0d835582f ("ASoC: stm32: sai: simplify sync modes management")
>>> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
>>> ---
>>>    sound/soc/stm/stm32_sai.c | 11 ++++++++---
>>>    1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
>>> index bcb35ca..14c9591 100644
>>> --- a/sound/soc/stm/stm32_sai.c
>>> +++ b/sound/soc/stm/stm32_sai.c
>>> @@ -112,16 +112,21 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
>>
>> goto error also in previous test
>>        if (!pdev) {
>>                ...
>>                ret = -ENODEV;
>>                 goto error;
>>         }
>>
>>>        if (!sai_provider) {
>>>                dev_err(&sai_client->pdev->dev,
>>>                        "SAI sync provider data not found\n");
>>> -             return -EINVAL;
>>> +             ret = -EINVAL;
>>> +             goto out_put_dev;
>>>        }
>>>
>>>        /* Configure sync client */
>>>        ret = stm32_sai_sync_conf_client(sai_client, synci);
>>>        if (ret < 0)
>>> -             return ret;
>>> +             goto out_put_dev;
>>>
>>>        /* Configure sync provider */
>>> -     return stm32_sai_sync_conf_provider(sai_provider, synco);
>>> +     ret = stm32_sai_sync_conf_provider(sai_provider, synco);
>>> +
>>> +out_put_dev:
>>> +     put_device(&pdev->dev);
>>> +     return ret;
>>
>> Here I propose:
>> error:
>>         of_node_put(np_provider);
>>         return ret;
>>
>>>    }
>>>
>>>    static int stm32_sai_probe(struct platform_device *pdev)
>>>
> 
>> Thanks for your patch. Please, see my comments above.
> 
> Thanks for your comments, in this patch we only fix the problem of missing put_device().
> The problem of missing of_node_put() is a bit more complicated:
> For the variable np_provider(np_sync_provider):
> 1, it is obtained by of_get_parent(), but it is not released;
> 2, error code not obtained when calling sai->pdata->set_sync()
> 

I agree, release of np_sync_provider node is missing, as well as
returned error on set_sync.
So yes, this requires a dedicated patch.
Thanks

Regards
Olivier

> We will submit another patch to fix the failure of np_sync_provider
> Thank you.
> > Regards
> Wen
> 
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
