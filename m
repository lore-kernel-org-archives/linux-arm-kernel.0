Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE0AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:50:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9225D20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mj7UTHxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9225D20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ewxFIpffHulJxQ07tjrewziGgMp2eSUwsbP7x+0Mczw=; b=Mj7UTHxD0aFA6A
	rtVgig5qzOKDCSLCmihtNXPl29O3/0GUVKSe33jIKy2fToQ7i6QOHoZH3bVNtJJzfb64hJkwljxcA
	x0IP616wnskjgDrEZ7SB2g7tGyodIh11TA0gy4KW8/+CVwefcA9beHHFNiFVzpUNbztiwPhuZ8kRq
	IXaVIOX4cgsEfJ5w9QKJrtafn5yGAEU4FeQ0ioVSa+pV5Tuskv9U7n0ZzCaZ5fs4PYcscYoqerkU5
	N3EBUkYapspnVPu3lIBLar9eFXYyWnFWP+Erl0ZHXRzi56LcpysW+kuvh4V9UU0B7fb6ltufrZJkl
	l5ZJP8tP+dlmh5LZwYaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggQcM-00089R-RS; Mon, 07 Jan 2019 08:50:42 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggQcJ-00084P-3k
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 08:50:41 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x078fexa030486; Mon, 7 Jan 2019 09:50:18 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2ptybmp9pv-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 07 Jan 2019 09:50:18 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 63D743D;
 Mon,  7 Jan 2019 08:50:17 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C6AB2713;
 Mon,  7 Jan 2019 08:50:17 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 7 Jan
 2019 09:50:16 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Mon, 7 Jan 2019 09:50:16 +0100
From: Patrice CHOTARD <patrice.chotard@st.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Vinod Koul
 <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] dmaengine: st_fdma: use struct_size() in kzalloc()
Thread-Topic: [PATCH] dmaengine: st_fdma: use struct_size() in kzalloc()
Thread-Index: AQHUpF1ix7uI5wB8fU21b6FQMnj6mKWjcoWA
Date: Mon, 7 Jan 2019 08:50:16 +0000
Message-ID: <d5817730-980d-0295-d4fb-43bd34b89e7e@st.com>
References: <20190104184322.GA9615@embeddedor>
In-Reply-To: <20190104184322.GA9615@embeddedor>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-ID: <6A6E5608DF6E9D4EA4E25F48D85F6408@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-07_03:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_005039_447542_25157D5A 
X-CRM114-Status: GOOD (  17.92  )
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
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Gustavo

On 1/4/19 7:43 PM, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/dma/st_fdma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
> index 07c20aa2e955..df6b73028ecb 100644
> --- a/drivers/dma/st_fdma.c
> +++ b/drivers/dma/st_fdma.c
> @@ -243,8 +243,7 @@ static struct st_fdma_desc *st_fdma_alloc_desc(struct st_fdma_chan *fchan,
>  	struct st_fdma_desc *fdesc;
>  	int i;
>  
> -	fdesc = kzalloc(sizeof(*fdesc) +
> -			sizeof(struct st_fdma_sw_node) * sg_len, GFP_NOWAIT);
> +	fdesc = kzalloc(struct_size(fdesc, node, sg_len), GFP_NOWAIT);
>  	if (!fdesc)
>  		return NULL;
>  
> 


Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
