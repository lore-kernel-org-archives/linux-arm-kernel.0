Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACADC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:47:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74ED72081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sk6nL7fB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74ED72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+p1/5bYmXETHc3rnLq68bk6PxzSujKDAPoQELffzy7I=; b=sk6nL7fB+mtBxO
	UtQLz+jC5WBEgGxGpcBfNU1KS7dVw8br+iqaBk32YQuN/tZ4MRE8pAYE+VXAnTOjPQDwTzkGOxait
	exS28sKnotJU9wDksO/D2u4THLaXkWL1PbLsHvHTA/NdzptGSfbRqIfmdb3Mtmg2pughcsPiRQ35M
	HF+ph4iMoOJPNUiESvttCjbiDZpHfevN9iucrsnubE9ALEx0JQSwy0rWrjs5MTG9yovT0NTNr0xpr
	ihgLCpdmwloxGBaLNfDnSY8VilrWNXrcst7JZj5FLYyCRrBscMHBi4E1+M+fwPQJSuUTkPDJLyYGF
	yUlLhW/Nv1uqP0Ej/JZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grIrM-0006SF-Bv; Wed, 06 Feb 2019 08:47:08 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grIrJ-0006Rn-IW
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 08:47:07 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x168kQWh016804; Wed, 6 Feb 2019 09:46:59 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qfv9ng0sf-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 06 Feb 2019 09:46:59 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 87066370;
 Wed,  6 Feb 2019 08:46:58 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5E05516B8;
 Wed,  6 Feb 2019 08:46:58 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 Feb
 2019 09:46:58 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Wed, 6 Feb 2019 09:46:58 +0100
From: Patrice CHOTARD <patrice.chotard@st.com>
To: wen yang <yellowriver2010@hotmail.com>, "balbi@kernel.org"
 <balbi@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] USB: dwc3: add missing of_node_put()
Thread-Topic: [PATCH] USB: dwc3: add missing of_node_put()
Thread-Index: AQHUu3PhlWt5p92k+kmajluToxxENKXSaV2A
Date: Wed, 6 Feb 2019 08:46:57 +0000
Message-ID: <d969fab6-7658-c88a-ee01-a7fd75b8e9c0@st.com>
References: <HK0PR02MB363451C20715075F224345CEB26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
In-Reply-To: <HK0PR02MB363451C20715075F224345CEB26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-ID: <93E4B6A8CD0D964A802A8E1B5747D8ED@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-06_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_004705_889493_E332F483 
X-CRM114-Status: GOOD (  17.34  )
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
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Wen

On 2/3/19 4:52 AM, wen yang wrote:
> The call to of_find_node_by_name returns a node pointer with refcount
> incremented thus it must be explicitly decremented here after the last
> usage.
> The of_find_device_by_node() takes a reference to the underlying device
> structure, we also should release that reference.
> This patch fixes those 2 issues.
> 
> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/usb/dwc3/dwc3-st.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
> index 1608138..fdd90d2 100644
> --- a/drivers/usb/dwc3/dwc3-st.c
> +++ b/drivers/usb/dwc3/dwc3-st.c
> @@ -262,17 +262,18 @@ static int st_dwc3_probe(struct platform_device *pdev)
>  	ret = of_platform_populate(node, NULL, NULL, dev);
>  	if (ret) {
>  		dev_err(dev, "failed to add dwc3 core\n");
> -		goto undo_softreset;
> +		goto put_node;
>  	}
>  
>  	child_pdev = of_find_device_by_node(child);
>  	if (!child_pdev) {
>  		dev_err(dev, "failed to find dwc3 core device\n");
>  		ret = -ENODEV;
> -		goto undo_softreset;
> +		goto put_node;
>  	}
>  
>  	dwc3_data->dr_mode = usb_get_dr_mode(&child_pdev->dev);
> +	put_device(&child_pdev->dev);
>  
>  	/*
>  	 * Configure the USB port as device or host according to the static
> @@ -283,15 +284,18 @@ static int st_dwc3_probe(struct platform_device *pdev)
>  	ret = st_dwc3_drd_init(dwc3_data);
>  	if (ret) {
>  		dev_err(dev, "drd initialisation failed\n");
> -		goto undo_softreset;
> +		goto put_node;
>  	}
>  
>  	/* ST glue logic init */
>  	st_dwc3_init(dwc3_data);
>  
>  	platform_set_drvdata(pdev, dwc3_data);
> +	of_node_put(child);
>  	return 0;
>  
> +put_node:
> +	of_node_put(child);
>  undo_softreset:
>  	reset_control_assert(dwc3_data->rstc_rst);
>  undo_powerdown:
> 

Reviewed-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
