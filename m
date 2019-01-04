Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB82C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:45:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C76020815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VqA6q+CB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C76020815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+G/ydA+9DD9dPUsq0Uwa9vZ7FYm55DM4CEv/5lH3DhY=; b=VqA6q+CBt4kiWB
	RITKIH3BcfDkYN6L1GLsGYsoUUeaPhsRV9vJdm4TFcsW4NEkXLNgTL6GdbvFXqFFrUAIAeMZDeiNL
	nJeuWSPPkK9f5kX526r8y+fdcuuKXSsnwp9GvEvqaBnIDqya50SV0DnufujeDsLaVVB4SSzXPBaiF
	VItDm9ew2tIhxadNiWxv0+nRigk2z3L/9yBIIA/VuNt0B8QprFlcR2+5RK4TgrGMpvTLNbXBTSJW5
	22XPNOQhtd0MLUp76J0mIVI4YU6k9un+iMo9IKf7WRMkKDQcz73Ti/JkfAVfVUPJtUhuyDOtJxK28
	KXihF7n/m/8qvLMDR/gQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfFTl-0004ku-Ra; Fri, 04 Jan 2019 02:44:57 +0000
Received: from mail-it1-f193.google.com ([209.85.166.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfFTh-0004kX-JD
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 02:44:55 +0000
Received: by mail-it1-f193.google.com with SMTP id z7so48139608iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 18:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=diwqjDGc9sdTVKZvvVFpkAPDTc6C/pPT/CmD+S+0pW4=;
 b=dHli5yI6sxB+oyEfv0jjtWgYhzBlt5XlTW2FMlB8Bd4LVtGdvct6N/FcBSfFPRy2Zv
 z+KVmya9w7INNoWE1+8SwD5PFq2WdCiuQ3mgILq7AdkzftGI4hOfCpIqjbira+3VG1l5
 wpGvyl7O190IDNkwDUaCm9KUig7Nvo+RRD4jAEC5ewkEwWGvGMn16ZksalUjXGOHD3It
 djJxJ52fY9zfrfgC+OQ4rWkWDL3sbKla/cXNAks6OqYqRXISl9j4aYYW49W8bCHtYXWc
 fAYfz5Nfb9PCZNeLbHvIktvoHzaZDYi9NxpvrlCFmLFOPqGL6O8ZxuEkJywp3kiRTG+w
 ZSrw==
X-Gm-Message-State: AA+aEWbDSEfKwexK3svj757sYsTI0bgOUfGxe5eaqvOL3fhLJ2zoAbHt
 mYxDNq4u11EFCXFnqnVMTg==
X-Google-Smtp-Source: AFSGD/VwTgD/i9VU363h8Jvg9qeDVGJUo50bCe453VNvk/mCwW8afZMeMMyUPIgKhSiNxv5I9q7pQQ==
X-Received: by 2002:a24:f143:: with SMTP id q3mr33671999iti.42.1546569892534; 
 Thu, 03 Jan 2019 18:44:52 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id f13sm25307757iol.82.2019.01.03.18.44.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 18:44:51 -0800 (PST)
Date: Thu, 3 Jan 2019 20:44:49 -0600
From: Rob Herring <robh@kernel.org>
To: h00249924 <hutenghui@huawei.com>
Subject: Re: [PATCH 3/3] arm64: dts: hi3660: Add hisi asp dma device
Message-ID: <20190104024449.GB17431@bogus>
References: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
 <1545978983-124360-3-git-send-email-hutenghui@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545978983-124360-3-git-send-email-hutenghui@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_184453_637815_51B1D848 
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Youlin Wang <wwx575822@notesmail.huawei.com>, hanxiaolong3@hisilicon.com,
 suzhuangluan@hisilicon.com, hantanglei@huawei.com,
 linux-kernel@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
 kongfei@hisilicon.com, ninggaoyu@hisilicon.com,
 John Stultz <john.stultz@linaro.org>, liyuequan@hisilicon.com,
 dmaengine@vger.kernel.org, huangli295@hisilicon.com, wangyoulin1@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, cash.qianli@hisilicon.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 28, 2018 at 02:36:23PM +0800, h00249924 wrote:
> From: Youlin Wang <wwx575822@notesmail.huawei.com>
> 
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
> Signed-off-by: Tanglei Han <hantanglei@huawei.com>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index f432b0a..5223e36 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -1122,5 +1122,19 @@
>  				};
>  			};
>  		};
> +
> +		asp_dmac: asp_dmac@E804B000 {

dma-controller@e804b000

> +			compatible = "hisilicon,hisi-pcm-asp-dma-1.0";
> +			reg = <0x0 0xe804b000 0x0 0x1000>;
> +			#dma-cells = <1>;
> +			dma-channels = <16>;
> +			dma-requests = <32>;
> +			dma-min-chan = <0>;
> +			dma-used-chans = <0xFFFE>;

Use lowercase hex.

But more importantly, as John mentioned, this and other properties 
aren't documented.

> +			dma-share;
> +			interrupts = <0 216 4>;
> +			interrupt-names = "asp_dma_irq";
> +			status = "ok";

Don't need this.

> +		};
>  	};
>  };
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
