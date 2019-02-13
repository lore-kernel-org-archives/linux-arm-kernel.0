Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB443C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:42:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF952075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XMiLPSGx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ZoshAQgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF952075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YQN6tiyrMrLurfvfTOsY2p2M14/fMWvr4InG5zVBW94=; b=XMiLPSGxI8GbAB
	V3cMhuucywczaLB9AKz2OjrRku7EIzwFzbEB6zA9tKArQWP7ox5cGn1cL5vYazuW6DrqAUbn+Qo/a
	dCmZnq1wTWY5FYVNi7/c6YuYHWvIg7U+53FuDjcyEkOsuf7o2wQczuhhiV2Q1YHC7t/60A3l6ufej
	U7x7ilnqkyFLtGuWrFM67p18763b1m8KAajvmRtAHgqQy8uTvFPQnfpDG2eKzXzbU/GvseuEb1gLb
	rhhtgbW/N2AEP80ZyHq/eUOeN05pRNV/+TBVt/EjtkMVb7E765T2Awg+EjYObr2QJUNK5xZEQf39U
	uIOnkT7+QhqGtKk7su7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtvju-0003cM-IW; Wed, 13 Feb 2019 14:42:18 +0000
Received: from mail-sg2apc01olkn0815.outbound.protection.outlook.com
 ([2a01:111:f400:febd::815]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtvjc-0003GI-M4
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 14:42:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIFNsL7aTcB+IMl+NjSC44aehmvgZgSpdh1d4fLQUDg=;
 b=ZoshAQgR2U88+CzKU/Fyc5zDPOnmV9k3XOHmKoWuvgoYd8sIQNoZrCTUUeyASNM+BI9h8npDHCtOFvvuGY7Urz+pfN+pQdfQmeT4JuA78spzqr3Xs/0fUGu+1MSil7gZQvPCTIoMuFe2VCA6qMaRFjmwIKX+QcegYGmngWbKEapXopKAIX0wwI7sT+U937KaQl00+TzozY21bgj6hn5NXLKal+krzGzCngFCvuB/4Jj0Mboai2etc07KYXe2LXjTc8kb2jdclovDPnYErGQMPVSSVMvfqrCVELpABIfKgYFNKkgaJMKB8d2JjTb9gfOEzbullSTZEyp5YIczssad+w==
Received: from HK2APC01FT037.eop-APC01.prod.protection.outlook.com
 (10.152.248.58) by HK2APC01HT097.eop-APC01.prod.protection.outlook.com
 (10.152.249.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Wed, 13 Feb
 2019 14:41:53 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.248.55) by
 HK2APC01FT037.mail.protection.outlook.com (10.152.248.223) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Wed, 13 Feb 2019 14:41:53 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 14:41:53 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: Olivier MOYSAN <olivier.moysan@st.com>, Arnaud POULIQUEN
 <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Alexandre
 TORGUE" <alexandre.torgue@st.com>
Subject: Re: [PATCH] ASoC: stm32: sai: add missing put_device()
Thread-Topic: [PATCH] ASoC: stm32: sai: add missing put_device()
Thread-Index: AQHUwGP3BFaM6L9X70mSmjxl1QacOaXapgiAgAMsmOY=
Date: Wed, 13 Feb 2019 14:41:53 +0000
Message-ID: <HK0PR02MB3634F3A1A0C8BF4EEC5C3874B2660@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <HK0PR02MB36348FCAF73000463738C017B26A0@HK0PR02MB3634.apcprd02.prod.outlook.com>,
 <18decbe3-5a7c-1b75-4c64-0b16fdd0efec@st.com>
In-Reply-To: <18decbe3-5a7c-1b75-4c64-0b16fdd0efec@st.com>
Accept-Language: zh-CN, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:3016ED3047E6543F5F7239BD1B73B5AEE2CCBB657322634130C01E276E17A0DC;
 UpperCasedChecksum:41F4F565B25AF0BDF612B08132006B5043EE80486FFD14507B10E4794C3B1484;
 SizeAsReceived:7491; Count:45
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [o6BBQbMNno9DJuRxbeybwkTKWFhkoTwr]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-microsoft-exchange-diagnostics: 1; HK2APC01HT097;
 6:v9p/v0G6ZPIxnN2SLhXZyjBYw1o2HIapLkUORi1u25SHlRxYvQq55Va8K4gqhkZ5nqQ/8KA+J9QCL6HJ448LuNKhX4ezjcRY7+d8KLZoKf0j13BU2nnmTXNYUx9BzLncwlDfl8NZ1wkgEAL59tP3abqot+RQjH9JX1qV6U11Bvd4L1ic4JBDhO+CznTe4ZwqUfsSKmdLZgUgQURVjb9EuDGv4j9/ksw35tqybAP7dGb91wxfHxHVZ/37KtWsud2k7AeXeu2RuD3m1HdDBaInlxvYSgYUyupvJmad1ojjkGc/tbTh8eq7O/5EMmfY0dnKZHQ2nlPGvMujj7Dn3MQ8E17KkZAB58DDKSB+cP+MPCyuWyhcFN3RwBuKZvTpt98KK8QBiTZGXoYEryK7ecc92ny+rSB/8LlNwRQnks76jCZj8r2hVFZrS5doCihhbxj1t/HPI4zNV6N7jB8eIpsFUA==;
 5:Oi2zB7FJg1WkuDbs8NYDf/UcrDo6JTfyFixBAPt8ZJtowHOlyHFwr1HjJ1l3TaZcn1vK2/Lk0AAhPuPeDciH818NnGJRS2EdyRDLaGN9UavhclW2YZyCO0TW4LoyGn6bLOggvIvug6UJqkbQAr09CkLBMN2u1VPosuwOpwPp+A00tXr8k+4AIUINa7Uc0ka7EaC5GufKSGJjGOGORiQThA==;
 7:jLMCBSo69lcqeQO0a+mu5aGZOxDS/7e7ccKQi4ssYCi/fDyLXl9JCrHLSdyMTm96yVOBLOEW0PtBNePW9M7PXpqfMz+VZGhMoCcnEaz3MJqyzCL1vtW/Vv4C5F6IPBmtyD8MCYjnZyk+lAiV5JvA8A==
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);
 SRVR:HK2APC01HT097; 
x-ms-traffictypediagnostic: HK2APC01HT097:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:HK2APC01HT097; BCL:0; PCL:0; RULEID:; SRVR:HK2APC01HT097; 
x-microsoft-antispam-message-info: v+v29jyEZ05IBWUsnKRzAFI/+/T4G9f9FkGdO0dOH2d8fGy8X+tiLsQuujVtpICA
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: e68dc956-2aa2-4b0b-d785-08d691c16556
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 14:41:53.1887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_064200_817916_90AB3984 
X-CRM114-Status: GOOD (  12.73  )
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

From: Olivier MOYSAN <olivier.moysan@st.com>
Sent: 11 February 2019 15:09
To: Wen Yang; Arnaud POULIQUEN; Liam Girdwood; Mark Brown; Jaroslav Kysela; Takashi Iwai; Maxime Coquelin; Alexandre TORGUE
Cc: alsa-devel@alsa-project.org; linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: stm32: sai: add missing put_device()

>On 2/9/19 11:41 AM, Wen Yang wrote:
>> The of_find_device_by_node() takes a reference to the underlying device
>> structure, we should release that reference.
>>
>> Fixes: 7dd0d835582f ("ASoC: stm32: sai: simplify sync modes management")
>> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
>> ---
>>   sound/soc/stm/stm32_sai.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
>> index bcb35ca..14c9591 100644
>> --- a/sound/soc/stm/stm32_sai.c
>> +++ b/sound/soc/stm/stm32_sai.c
>> @@ -112,16 +112,21 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
>
>goto error also in previous test
>       if (!pdev) {
>               ...
>               ret = -ENODEV;
>                goto error;
>        }
>
>>       if (!sai_provider) {
>>               dev_err(&sai_client->pdev->dev,
>>                       "SAI sync provider data not found\n");
>> -             return -EINVAL;
>> +             ret = -EINVAL;
>> +             goto out_put_dev;
>>       }
>>
>>       /* Configure sync client */
>>       ret = stm32_sai_sync_conf_client(sai_client, synci);
>>       if (ret < 0)
>> -             return ret;
>> +             goto out_put_dev;
>>
>>       /* Configure sync provider */
>> -     return stm32_sai_sync_conf_provider(sai_provider, synco);
>> +     ret = stm32_sai_sync_conf_provider(sai_provider, synco);
>> +
>> +out_put_dev:
>> +     put_device(&pdev->dev);
>> +     return ret;
>
>Here I propose:
>error:
>        of_node_put(np_provider);
>        return ret;
>
>>   }
>>
>>   static int stm32_sai_probe(struct platform_device *pdev)
>>

>Thanks for your patch. Please, see my comments above.

Thanks for your comments, in this patch we only fix the problem of missing put_device().
The problem of missing of_node_put() is a bit more complicated:
For the variable np_provider(np_sync_provider):
1, it is obtained by of_get_parent(), but it is not released;
2, error code not obtained when calling sai->pdata->set_sync()

We will submit another patch to fix the failure of np_sync_provider
Thank you.

Regards
Wen



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
