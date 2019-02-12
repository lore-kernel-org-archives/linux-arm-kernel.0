Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC69C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:28:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0872084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NFm8ZVcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0872084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GBjDwBaTNUlOzBcoVaEyosnDF1iGmaeP1IIO+XRetPQ=; b=NFm8ZVczFkNk5d
	aN5ad97DII9xLdjaestLBQJrs6fpzfk/tiXLDJA1G1LOPI9cSvTvSjcRKnFXIpqpKB64FG1RrwJhl
	sX0tk/qR4sQPb9kf54+EH0cD1McsrcVjy9AnytQFGoFsHm1zlFim4DgY+u7SeJy5rZ+6l9ai3XOuP
	7ZHq7Tse7rqnp8J2DofcI43jHRDnqQ/BopIOQcjuMYJgKA74c3NxNQ04ExBLokGSpjEpLBA5jVsdk
	9Jdt/b7wwN2S7twGQW0itEI76h7E7kiH1z3Gaez/opX96JKWH9OgMaf+6zAl1vI0DLX1IyWXJ9Smb
	rqVH9eeqAiByDg07qJbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtZzM-0006gR-Ku; Tue, 12 Feb 2019 15:28:48 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtZz3-0006Pt-GA
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 15:28:33 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1CFGUqq031812; Tue, 12 Feb 2019 16:28:25 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qjfy65khf-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Tue, 12 Feb 2019 16:28:25 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C6C0F38;
 Tue, 12 Feb 2019 15:28:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4DF4A5470;
 Tue, 12 Feb 2019 15:28:23 +0000 (GMT)
Received: from SFHDAG4NODE2.st.com (10.75.127.11) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 12 Feb
 2019 16:28:22 +0100
Received: from SFHDAG4NODE2.st.com ([fe80::4457:45af:aece:883f]) by
 SFHDAG4NODE2.st.com ([fe80::4457:45af:aece:883f%20]) with mapi id
 15.00.1347.000; Tue, 12 Feb 2019 16:28:22 +0100
From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Alexandre
 TORGUE" <alexandre.torgue@st.com>
Subject: Re: [PATCH] Input: st-keyscan - fix potential zalloc NULL dereference
Thread-Topic: [PATCH] Input: st-keyscan - fix potential zalloc NULL dereference
Thread-Index: AQHUwucSbnUyh3E18kKgOKwxl5Aux6XcOJsA
Date: Tue, 12 Feb 2019 15:28:22 +0000
Message-ID: <e0967983-cab2-3c18-6c8a-a0333dc087ff@st.com>
References: <20190212152429.1936-1-gabriel.fernandez@st.com>
In-Reply-To: <20190212152429.1936-1-gabriel.fernandez@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-ID: <07234B400B9A124689DEB41218527AA9@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-12_08:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_072830_059388_DE873D08 
X-CRM114-Status: GOOD (  14.77  )
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Sorry ignore this patch (bad mailing list)

Best Regard

Gabriel

On 2/12/19 4:24 PM, gabriel.fernandez@st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>
> This patch fixes the following static checker warning:
>
> drivers/input/keyboard/st-keyscan.c:156 keyscan_probe()
> error: potential zalloc NULL dereference: 'keypad_data->input_dev'
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>   drivers/input/keyboard/st-keyscan.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
> index babcfb165e4f..3b85631fde91 100644
> --- a/drivers/input/keyboard/st-keyscan.c
> +++ b/drivers/input/keyboard/st-keyscan.c
> @@ -153,6 +153,8 @@ static int keyscan_probe(struct platform_device *pdev)
>   
>   	input_dev->id.bustype = BUS_HOST;
>   
> +	keypad_data->input_dev = input_dev;
> +
>   	error = keypad_matrix_key_parse_dt(keypad_data);
>   	if (error)
>   		return error;
> @@ -168,8 +170,6 @@ static int keyscan_probe(struct platform_device *pdev)
>   
>   	input_set_drvdata(input_dev, keypad_data);
>   
> -	keypad_data->input_dev = input_dev;
> -
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	keypad_data->base = devm_ioremap_resource(&pdev->dev, res);
>   	if (IS_ERR(keypad_data->base))
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
