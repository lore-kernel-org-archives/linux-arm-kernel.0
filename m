Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA989C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:32:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC12217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gD1qqZTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC12217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nOIBzg7iK8IRj6YOMIJVwUqBMC5/nkdPx1z+q4mfqoo=; b=gD1qqZToHTGjdW
	9mI3g7430WXYeCmDXLx6egoarE9Aj3u8Hv2A2VZcIkRlJaotLmGRB3xoNsyqSzKU3gVetO591TJXt
	7uPQv7G5dBl3leELeDWyjRl6UBXxWyX5eIMujnCtDQTGh/T8xTwPz6gt71rkvis1OEeQHXELA9Mxn
	gfjqAggQ3Hpek4+q10agER9BtijhF/Ci3G+/oYul+wE9YDdXto5UzDgsXA8llFJp1vn2pdKBb+d84
	4iufcDl+3XTDHsZ8/stEQarw7IiTomEYIruT/56YfGRcSyTVNHv6BZMvpAjtNHkXM2thvb8XwxGag
	cGjQgKVfF/g38dqd74Ug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gc4cS-0004IG-K5; Wed, 26 Dec 2018 08:32:48 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc4cP-0004HE-Cc
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 08:32:47 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 59FB2209ED; Wed, 26 Dec 2018 09:32:25 +0100 (CET)
Received: from localhost (uni14-h01-176-184-39-184.dsl.sta.abo.bbox.fr
 [176.184.39.184])
 by mail.bootlin.com (Postfix) with ESMTPSA id 029EC2072F;
 Wed, 26 Dec 2018 09:32:24 +0100 (CET)
Date: Wed, 26 Dec 2018 09:32:24 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH] atmel: fix a missing check of clk_prepare
Message-ID: <20181226083224.GR2188@piout.net>
References: <20181226025405.72480-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181226025405.72480-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_003245_567001_462F0976 
X-CRM114-Status: GOOD (  14.03  )
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>, pakki001@umn.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 25/12/2018 20:54:05-0600, Kangjie Lu wrote:
> clk_prepare() could fail, so let's check its status, and if it fails,
> issue an error message.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/misc/atmel-ssc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> index d8e3cc2dc747..9e69d0585f49 100644
> --- a/drivers/misc/atmel-ssc.c
> +++ b/drivers/misc/atmel-ssc.c
> @@ -60,7 +60,8 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
>  	ssc->user++;
>  	spin_unlock(&user_lock);
>  
> -	clk_prepare(ssc->clk);
> +	if (clk_prepare(ssc->clk))
> +		pr_err("ssc: failed to prepare clk.\n");
>  

There is no point in adding this check and yet another string to please
a static analysis tool. This is especially true because clk_prepare will
never actually fail else you wouldn't reach this code anyway.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
