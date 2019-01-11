Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B270C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:35:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0112084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UM5hE4Uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0112084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=awAHGH0w0MmNtwAoJ4Lr5zmdC824vz0LT5mytUGVLv0=; b=UM5hE4Uuxt0Le9
	ZaskQzfM65cn8Aovwkka3txH6iEIIG9hBQTMhiNG0Q0qxczbC/MC+03FwjUWnrQrUnLKSqv7VOJfg
	8RTgq1HE/1ICoM+oW30BMRoC6K69mM0QAg2ExvnBwvYgLn0pl3GP55mNfD+7Lu3KSgjNejthbENZ0
	TwtQOQ40WTriCb4dIqCc9WgOxMQ4Ne22a//CEevvgy1m1iK+kEW5M9XJdYkkREU1C6hQChPF5S3Ku
	+VtHaqmwiYUr7ekjuvXZ1mWnLY4qOnXnwEWrCaog0foqRL0mNKBd/TgC9N8yyEOP1AcCOTA0gsrSz
	HJYrSA/WJQIuoIhxDBSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi4SK-0006lc-Ur; Fri, 11 Jan 2019 21:35:08 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi4SH-0006Gh-45
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 21:35:06 +0000
Received: by mail-oi1-f195.google.com with SMTP id y1so13375187oie.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 13:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5MWqOYhYwGRYsdVb7b1Gquk64PwL2N180mchzXe8hHU=;
 b=MpSGymS80k8g28hkeKKk3WnKpKfXs1YLimbBBG4vdUlWQMg3VZOb+Vn9keY9aZRxf6
 lFMf+eUpPKkVjEZGDY62/z5dSz1kSThE5Bae4SY/mUXazHoyT0WcELlwWynN6zg6Y56V
 NLSjV7junU8N/6gWPjX+WbYrSc4QgTvlaVVg4jqvGOFjDZkNcqQCc6C+oVkXcDGqOzVc
 JTouLy8vheKj1iVgeOTKhaKfskOew5xRiRanT2OWIhPzFsA062t7qX5lwZ2+4QNs5YlC
 e06gN/TQ2ZbDRpPjMOgsy+hCEMA+TrqxK54j2MmphTjLnv7K8x0HCiEY41Ur4EFmnKhd
 tlqw==
X-Gm-Message-State: AJcUukcYd9359ka7ufSGtlasjQAVzeqLwuriFE7C/lcv0M+rSqArSMYN
 on+nDCAN4n4b35kpYsN1pg==
X-Google-Smtp-Source: ALg8bN6mpGBPwYnBZ268kFRALbuEVluToB6AIiv0hNqYAQASMOhkeNRC9y6SKxT3nONjqvK/k7HMug==
X-Received: by 2002:aca:4506:: with SMTP id s6mr9678093oia.115.1547242503832; 
 Fri, 11 Jan 2019 13:35:03 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id a201sm45360684oii.27.2019.01.11.13.35.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 13:35:03 -0800 (PST)
Date: Fri, 11 Jan 2019 15:35:02 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: ufs: Add HI3670 UFS controller binding
Message-ID: <20190111213502.GA24538@bogus>
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
 <20190105072859.9134-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190105072859.9134-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_133505_269012_65F28798 
X-CRM114-Status: GOOD (  11.15  )
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
Cc: devicetree@vger.kernel.org, jejb@linux.vnet.ibm.com,
 linux-scsi@vger.kernel.org, martin.petersen@oracle.com, guodong.xu@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, robh+dt@kernel.org,
 john.stultz@linaro.org, liwei213@huawei.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 vinholikatti@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat,  5 Jan 2019 12:58:57 +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for HI3670 UFS controller. HI3760 SoC is very
> similar to HI3660 SoC with almost same IPs. Only major difference in terms
> of UFS is the PHY. HI3670 has 10nm PHY. But since the original driver
> (HI3660 UFS) cannot make HI3670 UFS functional, a separate compatible
> is added for HI3670 without any fallback.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
