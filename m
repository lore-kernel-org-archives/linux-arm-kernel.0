Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF74C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:36:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F8720660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GbybPowB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZW0YtRU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F8720660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PcrgHDAcGBIC2MkqEQzZUeMp2yKw0wAX4bkYiBWJz70=; b=GbybPowBbZDCRp
	bZZFImKjDTh5YXxD3q7m+Nl8E6g59Jp7kOayWN3IW3AfMsSV9cxuQddsfiQhgANdZXc0z2ntp2Z1T
	iVUqRGrFxinsq3Rug4ZnRUnqMtsBSOWo7Sig02TliCSqZM7jE1vN1AvO1W0TfY9evx2bPS4F7J3zs
	W00nr/5W1LvmnDoz1mD6TA2aI5EJNXRYU1ASR9TQq8rLJUEVV27TGjVNRz/EPEN2pZLw56vrqjJss
	/gGyW+ouh9icG9Z6jBLpZXqQ4R6XRCn/oIKudIIM1FesNypnMalB3BT4SyRNoYfqIj9rChNWffa3p
	Qq5pVeSfrmx9V1AcAc1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gixjk-0007oe-UQ; Mon, 14 Jan 2019 08:36:48 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gixjh-0007nX-Ds
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 08:36:47 +0000
Received: by mail-pl1-x644.google.com with SMTP id g9so9831075plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 00:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Eyav2Xd4vPIbQq+IXEwcBzhuQ0gqy8aeKKbOWnFHlow=;
 b=ZW0YtRU78Dc20Bwt9j0gcxCswyNmcX6SDlpyvA4f7oXu2bEl9pmO9Zc9RZkG1gWZdH
 qKo+FBfo+fd53pWJrXW15qOurdpzkqGwU0Kcw5RBvkYHfS9sjCsP9WtwcVgmNAz4D8vG
 QPOWUwF3HwLG034qbAFikR2lZ2Rgufzg4A+Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Eyav2Xd4vPIbQq+IXEwcBzhuQ0gqy8aeKKbOWnFHlow=;
 b=Skxpvfw5hOa/72ZnGxXGewiKz+egMd0EDTbUu72qV5EsiaAKgUvirSB8WgeXjDWask
 K2wFRrmIEa7ebw4eBW5uhvXFQv5ioEW2hG4AgvRRrbggvvbfPpzMGbgNsOuSjz2o67ay
 5ZeVWlpgGIjJcNIcLj4WTNoz9C5AetegxNiYddsPBpvEGw0sGN4TT6nUpObpAGqmugCj
 y4Ik2LGmDfoWD7+zCEZzDvLHe6FjAC2CTVRpPEgbGL1U/4PGpJf8yQfb+G21gmZR+6Ob
 ZVp53UMuPmc3MxmItsAsnnxHeoyfxDzVZW0a9X2SoFxfiWCjw3ZbnjRQlnc1cDmd8Egi
 1D5w==
X-Gm-Message-State: AJcUukebrXQJvay2KmJPp+eJa1UWhpATdCb/ahwD2pH2RCXu2QLSYrOd
 66IrpfC2ZkcZZs6slEdKNt5T5g==
X-Google-Smtp-Source: ALg8bN5AKnOcdFbgQl6BzYaNZaVwpK57EQrzb60ctv+Sq0OKOZMNpxJr4blxpMNaqhlfRQeFYnRhvA==
X-Received: by 2002:a17:902:bf0c:: with SMTP id
 bi12mr24723607plb.0.1547455004352; 
 Mon, 14 Jan 2019 00:36:44 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li421-24.members.linode.com. [50.116.3.24])
 by smtp.gmail.com with ESMTPSA id 4sm141415516pfq.10.2019.01.14.00.36.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 00:36:43 -0800 (PST)
Date: Mon, 14 Jan 2019 16:36:38 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] arm64/hisilicon: fix SDcard detection
Message-ID: <20190114083638.GA12459@leoy-ThinkPad-X240s>
References: <1547454274-1674-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547454274-1674-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_003645_470981_FE728661 
X-CRM114-Status: GOOD (  16.52  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, xuwei5@hisilicon.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Vincent,

On Mon, Jan 14, 2019 at 09:24:34AM +0100, Vincent Guittot wrote:
> The SDcard detection of hikey960 is active low so cd-inverted is wrong.
> Instead of adding cd-inverted, we should better set correctly cd-gpios
> to use GPIO_ACTIVE_LOW.

Just remind, usually ARM maintainer has requirement for subject as:
'arm64: dts: hikey960: xxxx'.

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> SD card detection was not working on v5.0-rc1 but patch
> https://marc.info/?l=linux-mmc&m=154637189021211&w=2 makes it work.
> Nevertheles, latest changes in of_mmc_detection makes possible to have 
> a correct DT config.
> 
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index 71bfe41..dc314e7 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -665,8 +665,7 @@
>  	sd-uhs-sdr50;
>  	sd-uhs-sdr104;
>  	disable-wp;
> -	cd-inverted;
> -	cd-gpios = <&gpio25 3 0>;
> +	cd-gpios = <&gpio25 3 GPIO_ACTIVE_LOW>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sd_pmx_func
>  		     &sd_clk_cfg_func
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
