Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83148C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:07:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EDAE20665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rHaolXjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDAE20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wXjiWpACbSOcqQccDFh6mibD+fEGOd3s1sU36p7EceE=; b=rHaolXjGpAVtg4
	6sb4RhxJEti8NEj5rPtm5znKmIM4S8nYEvK+6+G0++WR8+aVgGvFw4JtOxq7CVYWgGqN5AeTxCBhZ
	aIXUxnOWhcwuG8kapBpTm5z4wXyeXxTUX/w7tHt98rDJC/psrzpWLV57anYzPcfJ5P4jjODEX/lRw
	fI28Jph/PQaZxpYdbuKTcFyvGTJEwMoTUEmizpIFflw83hSXwB40Vmd7PH3xXyfm1DqjhicCjVdZM
	nDmj2F6gyxOHodC3IwnDpYCTRQLozbWJKUd+xUgschvNv4UKbVFvqk5IVDVS1p4WdC6fS++4ljjZi
	QwBjqw7NxAOrypej1ZxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfKVY-0006rG-BK; Fri, 04 Jan 2019 08:07:08 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfKVS-0006qC-VA
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 08:07:06 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0485tJ9003055; Fri, 4 Jan 2019 09:06:51 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2psx6msdvx-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 04 Jan 2019 09:06:51 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E3C3631;
 Fri,  4 Jan 2019 08:06:49 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B8FF6267B;
 Fri,  4 Jan 2019 08:06:49 +0000 (GMT)
Received: from [10.129.7.168] (10.75.127.47) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 4 Jan
 2019 09:06:48 +0100
Subject: Re: [PATCH] dmaengine: stm32-mdma: Add a check on read_u32_array
To: Aditya Pakki <pakki001@umn.edu>
References: <20181228192641.9713-1-pakki001@umn.edu>
From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <8412ac64-cd6d-7390-87a1-24f5e7cdf87a@st.com>
Date: Fri, 4 Jan 2019 09:05:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181228192641.9713-1-pakki001@umn.edu>
Content-Language: en-US
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-04_04:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_000704_484954_1624D6B5 
X-CRM114-Status: GOOD (  15.94  )
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
Cc: Alexandre Torgue <alexandre.torgue@st.com>, kjlu@umn.edu,
 linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, dmaengine@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello

Acked-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Regards

On 12/28/18 8:26 PM, Aditya Pakki wrote:
> In stm32_mdma_probe, after reading the property "st,ahb-addr-masks", the
> second call is not checked for failure. This time of check to time of use
> case of "count" error is sent upstream.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/dma/stm32-mdma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
> index 390e4cae0e1a..485dea177704 100644
> --- a/drivers/dma/stm32-mdma.c
> +++ b/drivers/dma/stm32-mdma.c
> @@ -1579,9 +1579,11 @@ static int stm32_mdma_probe(struct platform_device *pdev)
>  
>  	dmadev->nr_channels = nr_channels;
>  	dmadev->nr_requests = nr_requests;
> -	device_property_read_u32_array(&pdev->dev, "st,ahb-addr-masks",
> +	ret = device_property_read_u32_array(&pdev->dev, "st,ahb-addr-masks",
>  				       dmadev->ahb_addr_masks,
>  				       count);
> +	if (ret)
> +		return ret;
>  	dmadev->nr_ahb_addr_masks = count;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
