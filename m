Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6ACC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:02:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88AA520849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BgpN7LNx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="hjTc+Ajh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AA520849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:
	Subject:To:From:Date:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u7k+9tYaVuY/F0vBfBxKR/d+SdHOtqL2OeUhqd1BMZA=; b=BgpN7LNxmyHORT
	W8K18lyvlgBNMrSCKwRFPypVubLDLXw/mWl4zoSWn2D7vgYUDYlVa4Kbc5a35sr2qXBF6we1/HVLq
	/aECVI2f0JH0MwAu3s/RuxHtfSeEV49mblkrUi4FvfdLWz1mB/NoqTGMFEVRLxaUQ7+MP0KFokxxg
	KpF0jHAeQ47IjAl5bDRyFJoCRB9jKAMrn2NqK1/dt2J4Y08Izs1zbh6i53FBxNtYZWr4mVPFHOywX
	+PELyDFfagJQlRNFYy8YCgRsT4LhSc3ieA7BJz8so1EZn2aeRc1H5g0ewnMBeKLwx8zuT6zWCSj+1
	Dqo/XYArFc7r8f9nKQmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWhgH-0006rl-8C; Tue, 11 Dec 2018 13:02:33 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWhgA-0006qx-CN
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:02:31 +0000
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 9F3F75C0D6B;
 Tue, 11 Dec 2018 14:02:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1544533332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwh/4+vx9X8/Ijdt33JICmzWM0pbU/GMdDqeieDRNHM=;
 b=hjTc+AjhJ2Z2T4NBM6WIKGzej7ZwMVC1M5Ss/Wy5F9cEIiVwqB4XSiohnpbKZlA4kjB4l6
 Z9Tgwla8n4+RFGpErI9ksl3Azdhdu5+1AQdc3nmg/3hu17F9CiPcoNqVQn4fcnxRgTgVIN
 +cLVkoYt0YpKYKX49kFhySFlX//2jCo=
MIME-Version: 1.0
Date: Tue, 11 Dec 2018 14:02:11 +0100
From: Stefan Agner <stefan@agner.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/5] ARM: actions: Put OF nodes after use
In-Reply-To: <20181211080759.3150-1-linus.walleij@linaro.org>
References: <20181211080759.3150-1-linus.walleij@linaro.org>
Message-ID: <71214b71090137e10ca08c9f291764aa@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_050226_730536_4692846E 
X-CRM114-Status: GOOD (  14.53  )
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
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 linux-arm-kernel@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11.12.2018 09:07, Linus Walleij wrote:
> After using of_find_compatible_node() we need to issue
> of_node_put() on the node to keep refcount.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-actions/platsmp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
> index 3efaa10efc43..02d17ed0ca31 100644
> --- a/arch/arm/mach-actions/platsmp.c
> +++ b/arch/arm/mach-actions/platsmp.c
> @@ -122,6 +122,7 @@ static void __init s500_smp_prepare_cpus(unsigned
> int max_cpus)
>  	}
>  
>  	timer_base_addr = of_iomap(node, 0);
> +	of_node_put(node);
>  	if (!timer_base_addr) {
>  		pr_err("%s: could not map timer registers\n", __func__);
>  		return;
> @@ -134,6 +135,8 @@ static void __init s500_smp_prepare_cpus(unsigned
> int max_cpus)
>  	}
>  
>  	sps_base_addr = of_iomap(node, 0);
> +	of_node_put(node);
> +

Can you drop this newline to be consistent?

Otherwise looks good to me:

Reviewed-by: Stefan Agner <stefan@agner.ch>

>  	if (!sps_base_addr) {
>  		pr_err("%s: could not map sps registers\n", __func__);
>  		return;
> @@ -147,6 +150,7 @@ static void __init s500_smp_prepare_cpus(unsigned
> int max_cpus)
>  		}
>  
>  		scu_base_addr = of_iomap(node, 0);
> +		of_node_put(node);
>  		if (!scu_base_addr) {
>  			pr_err("%s: could not map scu registers\n", __func__);
>  			return;

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
