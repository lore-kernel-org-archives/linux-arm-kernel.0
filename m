Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDDDC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:10:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07ED222B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sHzRmPIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07ED222B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o8PlMlPujsB7IjMLeJ3zX2DnxmkqUVL3F2kv/Ccuy48=; b=sHzRmPIh68oAmA
	dwLccvYI+raGzgCDffAUd9/Hasw1MvaylULawbpVXmMgPzFBCY5JphV5zFYe77x+NWFprnvAHvvOl
	q3vJXLmp639jmJ5ZxDkwe/kOYLscZk+wqmGHtL5QKr93RUfAffg6eDGS/54PiRWRCy0rvtScp4vfh
	NbGIApIpM52+Ik37uZrPhdXFXemWUMtNPyZy94kUESPDJ10iLTjI54DGgXXTelBDRYLrbNNDpvvZ3
	bHz+MNobBHAWYZjXHYG8+5MGNClKVH4V8AiBaeZ87UZOavRAQ8Dk+/IhMbwnoDNu+TB5s57o9R43D
	c5IA5NnRVGmtp3f6xTbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtDDw-0005Z0-JP; Mon, 11 Feb 2019 15:10:20 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtDDb-0004Qe-GH
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 15:10:05 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1BF1T0V016107; Mon, 11 Feb 2019 16:09:48 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qhurutqcc-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 11 Feb 2019 16:09:48 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 094DB3F;
 Mon, 11 Feb 2019 15:09:46 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4CB52BFE;
 Mon, 11 Feb 2019 15:09:46 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 11 Feb
 2019 16:09:46 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Mon, 11 Feb 2019 16:09:45 +0100
From: Olivier MOYSAN <olivier.moysan@st.com>
To: Wen Yang <yellowriver2010@hotmail.com>, Arnaud POULIQUEN
 <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Alexandre
 TORGUE" <alexandre.torgue@st.com>
Subject: Re: [PATCH] ASoC: stm32: sai: add missing put_device()
Thread-Topic: [PATCH] ASoC: stm32: sai: add missing put_device()
Thread-Index: AQHUwGP3BFaM6L9X70mSmjxl1QacOaXapgiA
Date: Mon, 11 Feb 2019 15:09:45 +0000
Message-ID: <18decbe3-5a7c-1b75-4c64-0b16fdd0efec@st.com>
References: <HK0PR02MB36348FCAF73000463738C017B26A0@HK0PR02MB3634.apcprd02.prod.outlook.com>
In-Reply-To: <HK0PR02MB36348FCAF73000463738C017B26A0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-ID: <ABCA28EC5FF04745816A6E3ADDD618BB@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-11_10:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_071000_096105_69DA2BE7 
X-CRM114-Status: GOOD (  16.60  )
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

Hi Wen,

On 2/9/19 11:41 AM, Wen Yang wrote:
> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.
> 
> Fixes: 7dd0d835582f ("ASoC: stm32: sai: simplify sync modes management")
> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> ---
>   sound/soc/stm/stm32_sai.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
> index bcb35ca..14c9591 100644
> --- a/sound/soc/stm/stm32_sai.c
> +++ b/sound/soc/stm/stm32_sai.c
> @@ -112,16 +112,21 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,

goto error also in previous test
	if (!pdev) {
		...
		ret = -ENODEV;
		goto error;
	}

>   	if (!sai_provider) {
>   		dev_err(&sai_client->pdev->dev,
>   			"SAI sync provider data not found\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out_put_dev;
>   	}
>   
>   	/* Configure sync client */
>   	ret = stm32_sai_sync_conf_client(sai_client, synci);
>   	if (ret < 0)
> -		return ret;
> +		goto out_put_dev;
>   
>   	/* Configure sync provider */
> -	return stm32_sai_sync_conf_provider(sai_provider, synco);
> +	ret = stm32_sai_sync_conf_provider(sai_provider, synco);
> +
> +out_put_dev:
> +	put_device(&pdev->dev);
> +	return ret;

Here I propose:
error:
	of_node_put(np_provider);
	return ret;

>   }
>   
>   static int stm32_sai_probe(struct platform_device *pdev)
> 

Thanks for your patch. Please, see my comments above.

Regards
Olivier


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
