Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4355C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:43:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAA120663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YsJnINcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAA120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QIhJ2xf6SiWyYaU0mflNkUnJb8EzybicR0DDS5+YO+g=; b=YsJnINcCo1avq3Hwy9VRM4nnk
	QgtRH0V4tjTxQzXqvn9ouG9Dxy0hURgtqwV89UduEsZrwEgjZyh3NXwZdWAxfKui2UXxBMi8s0QsY
	IpcRoHilHREHjYDPVAypVxPZzC1AtVQqFGpuekPNQwgtdqDgxgaYMbH2hQ59lUkDSOh3y1BXbPA1L
	K0I7omhskJr8R2ZLW8diI8B7pl9iYBc3uXr2rERBfvmz3tSzNXXYDqbM6b4qM8fwZrXWeVsvgJ9OG
	gMyzVNAwNeL/KrnHomAyT09AHcVB8G3xcG3Sx8/hqEumgDhFkleUhJnvBy/Wkog0cU1J0R5PWD6UT
	cBAgrGMSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghHso-0007nv-21; Wed, 09 Jan 2019 17:43:14 +0000
Received: from gateway31.websitewelcome.com ([192.185.143.38])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghHsl-0007nN-6G
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 17:43:12 +0000
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
 by gateway31.websitewelcome.com (Postfix) with ESMTP id 9B9E535779
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  9 Jan 2019 11:43:09 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id hHsjg1E6NiQerhHsjg2dVO; Wed, 09 Jan 2019 11:43:09 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=53380 helo=[192.168.43.131])
 by gator4166.hostgator.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1ghHsj-003wIM-28; Wed, 09 Jan 2019 11:43:09 -0600
Subject: Re: [PATCH] dmaengine: st_fdma: use struct_size() in kzalloc()
To: Patrice CHOTARD <patrice.chotard@st.com>, Vinod Koul <vkoul@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>
References: <20190104184322.GA9615@embeddedor>
 <d5817730-980d-0295-d4fb-43bd34b89e7e@st.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <e9895775-f1d6-cc64-6df9-f6b75cc2bb5c@embeddedor.com>
Date: Wed, 9 Jan 2019 11:43:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d5817730-980d-0295-d4fb-43bd34b89e7e@st.com>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ghHsj-003wIM-28
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:53380
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_094311_271638_09F7D43E 
X-CRM114-Status: GOOD (  14.84  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 1/7/19 2:50 AM, Patrice CHOTARD wrote:
> Hi Gustavo
> 
> On 1/4/19 7:43 PM, Gustavo A. R. Silva wrote:
>> One of the more common cases of allocation size calculations is finding the
>> size of a structure that has a zero-sized array at the end, along with memory
>> for some number of elements for that array. For example:
>>

[..]

>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/dma/st_fdma.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
>> index 07c20aa2e955..df6b73028ecb 100644
>> --- a/drivers/dma/st_fdma.c
>> +++ b/drivers/dma/st_fdma.c
>> @@ -243,8 +243,7 @@ static struct st_fdma_desc *st_fdma_alloc_desc(struct st_fdma_chan *fchan,
>>   	struct st_fdma_desc *fdesc;
>>   	int i;
>>   
>> -	fdesc = kzalloc(sizeof(*fdesc) +
>> -			sizeof(struct st_fdma_sw_node) * sg_len, GFP_NOWAIT);
>> +	fdesc = kzalloc(struct_size(fdesc, node, sg_len), GFP_NOWAIT);
>>   	if (!fdesc)
>>   		return NULL;
>>   
>>
> 
> 
> Acked-by: Patrice Chotard <patrice.chotard@st.com>
> 

Thanks, Patrice.

--
Gustavo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
