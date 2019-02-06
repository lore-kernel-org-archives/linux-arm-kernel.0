Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E49C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:40:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE28207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tcZ1NR9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE28207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HctjzMK/lfQ0+2piYvgm9OXC/Ibk3jkATaY9ClQGwik=; b=tcZ1NR9YrJosVg
	Ujttj8lg8m0O9+8KFKCjDiKLaGYhlCqR6KLr4pKmxSbVN4cdwXkG9tVq0JJ8ak+niXvdo9jLLcFHn
	/YYv3wkfnMQobgl9+riv1+KolSM67Mc4bK1BR/LryqLaDO+CvlM6UWWgT/KBX7pauoMldbeDPsh2T
	Msdg6bsTtBA14C1VhpU9w9jYNFhtS4JHPJ4eujy7ayCJtMWz1rGLNC78/VRt0HjvKZ5dJT2BBQdGI
	rKfonpqeOvDAovtxh6JxcRF9w9lqgGpjRH1k7OqpDa93w3wFlb10CtZVX0W7rsApfO1aP3buCvXqd
	yNrnOHLfBa8vI9kGguvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grIkS-0002z1-Sm; Wed, 06 Feb 2019 08:40:00 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grIkO-0002y2-7D
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 08:39:58 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x168cVXm016576; Wed, 6 Feb 2019 09:39:49 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qd1v0b643-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 06 Feb 2019 09:39:49 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B0B2F34;
 Wed,  6 Feb 2019 08:39:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 369401637;
 Wed,  6 Feb 2019 08:39:47 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 Feb
 2019 09:39:46 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Wed, 6 Feb 2019 09:39:46 +0100
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Yizhuo <yzhai003@ucr.edu>
Subject: Re: [PATCH] phy: Variable "val" in function miphy_osc_is_ready()
 could be uninitialized
Thread-Topic: [PATCH] phy: Variable "val" in function miphy_osc_is_ready()
 could be uninitialized
Thread-Index: AQHUvcxdxo2TQI+a9kuNUuZktxriraXSYqmA
Date: Wed, 6 Feb 2019 08:39:46 +0000
Message-ID: <a5bf0f11-3428-92de-e37a-96cce1952b36@st.com>
References: <20190206033036.22729-1-yzhai003@ucr.edu>
In-Reply-To: <20190206033036.22729-1-yzhai003@ucr.edu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-ID: <4AC3181D1CAB18499B9C4EC0B6633370@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-06_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_003956_558460_D0D2D8FD 
X-CRM114-Status: GOOD (  17.35  )
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
Cc: "csong@cs.ucr.edu" <csong@cs.ucr.edu>,
 "zhiyunq@cs.ucr.edu" <zhiyunq@cs.ucr.edu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Yizhuo

On 2/6/19 4:30 AM, Yizhuo wrote:
> In function miphy_osc_is_ready(), local variable "val"
> could be uninitalized. if function regmap_read() returns
> -EINVAL. However, this value is used in if statement.
> This is potentially unsafe.
> 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/phy/st/phy-miphy28lp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/st/phy-miphy28lp.c b/drivers/phy/st/phy-miphy28lp.c
> index 213e2e15339c..40c7c0a611a0 100644
> --- a/drivers/phy/st/phy-miphy28lp.c
> +++ b/drivers/phy/st/phy-miphy28lp.c
> @@ -835,7 +835,8 @@ static int miphy_osc_is_ready(struct miphy28lp_phy *miphy_phy)
>  {
>  	struct miphy28lp_dev *miphy_dev = miphy_phy->phydev;
>  	unsigned long finish = jiffies + 5 * HZ;
> -	u32 val;
> +	u32 val = 0;
> +	int ret;
>  
>  	if (!miphy_phy->osc_rdy)
>  		return 0;
> @@ -844,8 +845,10 @@ static int miphy_osc_is_ready(struct miphy28lp_phy *miphy_phy)
>  		return -EINVAL;
>  
>  	do {
> -		regmap_read(miphy_dev->regmap,
> +		ret = regmap_read(miphy_dev->regmap,
>  				miphy_phy->syscfg_reg[SYSCFG_STATUS], &val);
> +		if (ret)
> +			return ret;
>  
>  		if ((val & MIPHY_OSC_RDY) != MIPHY_OSC_RDY)
>  			cpu_relax();
> 

Reviewed-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
