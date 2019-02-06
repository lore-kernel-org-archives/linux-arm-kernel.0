Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E557FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:37:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A8C20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nasb0dM5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MZEQvWlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A8C20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QLcP/MeozJarX7InZ+Ox7rnffBLQ/qkWf+suKt9fKyg=; b=nasb0dM5C077NY
	7PI24rTdFuqjaVmAKF/spoOaRTSb56rKdlK1WOqUx2cejdYqNLWxHhATdwXNJmPS//W/m4P9fa8C4
	K3lQCgwkv5e2qofrkFl2JkSWickvJ61vwzQysqpBWIqCMzABzMRmTrV0+3QZimnNh1Oxg0gwnxaGv
	yfRuCPmGpSnfxYCIPSQebTvE9NXAMG6z9q4Jf0bdcNc6ALKnWuaRHOMvpc3Ju+ndn+6uCzopJ+ADt
	nnkDvigQlTCXKRHPr5PWk44ustNyAOAwbfDf1NZHmrgDG/NQDu6NJ+HWxzLEFXy9ALKRJava0W6j1
	zk2sTtJCtMXcTxey9WgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grLW6-0001gS-SE; Wed, 06 Feb 2019 11:37:22 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grLW2-0001g5-6g
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 11:37:21 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16BbGPf028665;
 Wed, 6 Feb 2019 05:37:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549453036;
 bh=s5K0Ey4SGK5w8YpCgMjlhFy0N+qYzohFi2PAXBpSKLs=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=MZEQvWlM/FJaDwHoTA7cl/Sy3GuQQ2ACMIvpB7fQXp73FZ53C149KU5qJOwudOEGH
 ATocw6WY3AdE5+0yrvuC5QR5L7IxSSDHee5ISKFEYswSD+iX5Vaa6vWEXONWTmdEGB
 i1nKhu9EOpdWEN3uFlhtVdahq0/aHXCC8gyeGjEg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16BbGiZ002507
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Feb 2019 05:37:16 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 05:37:16 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 05:37:16 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16BbD8W009284;
 Wed, 6 Feb 2019 05:37:14 -0600
Subject: Re: [PATCH] phy: Variable "val" in function miphy_osc_is_ready()
 could be uninitialized
To: Yizhuo <yzhai003@ucr.edu>
References: <20190206033036.22729-1-yzhai003@ucr.edu>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <f7b2aacc-21c9-0316-fc1f-20cecbb5af3b@ti.com>
Date: Wed, 6 Feb 2019 17:06:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206033036.22729-1-yzhai003@ucr.edu>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_033718_413534_97A4DDE0 
X-CRM114-Status: GOOD (  21.82  )
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
Cc: csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
 Patrice Chotard <patrice.chotard@st.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Yizhuo,

On 06/02/19 9:00 AM, Yizhuo wrote:
> In function miphy_osc_is_ready(), local variable "val"
> could be uninitalized. if function regmap_read() returns
> -EINVAL. However, this value is used in if statement.
> This is potentially unsafe.
> 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>

Can you send all your fixes in a series?

Thanks
Kishon
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

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
