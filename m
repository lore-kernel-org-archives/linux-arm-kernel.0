Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD18C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:09:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44572133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iHI/W0b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44572133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5pewdBHAoKQAa4iPUltIrr/Bbv/Sxqx7ejza98btFfI=; b=iHI/W0b42rr/Av
	n3Ue/aG+6LgTZ8xdgq3FnjilF56gMVmrL4ZtetFZsZ8qojpLIVQp16nN/SGdn5aYMG1uHj827l2dZ
	KELL4kLm1MGX69Hskuxl+cmAeNJULkB2kf5LaPX9prfShybLHg2lJ8zq8yCbEksDjVRipFrndCorj
	eU5mZk6b6tRV4DvJeUELGSRxoqWGKUpZCXxRPO/oWTHeiAqkDgtAT+n2qD4w54VFcZModNfH9xh8C
	ZeUqPoCDnpAnic5NcGoF1wGz0Tib9w27dC5qdG5DqGZo6zWiWxn9YJ1UVGCOWJqlEXcCrQCho90uJ
	wnDo+I+R5Fs1Pyi2SDtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi37f-0007eO-W6; Fri, 11 Jan 2019 20:09:44 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi37d-0007dz-Ad
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 20:09:42 +0000
Received: by mail-oi1-f193.google.com with SMTP id r62so13245332oie.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 12:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ozLB4eItNh38XiaTZC1HQmCoOYneLP4TFm8jXIMT24k=;
 b=ENgsGqJSxkwkVuK5XgpwAlbWjhkle2MWBjZPNOeA+Z2yIQxmA9IO63OqoRpCXIQUzw
 76klvLMVy8xaYyxwolzoYMH+xyvso2rJo7qc9Bwa9fIoKhtRFlcpiwJzOsTiMOfigEjB
 kBvyLfrBl31Ipox8VTwM9Nh95Uw14L8hO9OsLcnJQopeFPW23kJdV4/WLEaKU0H5A0/P
 eg59BXQ+Ja1VPOpyu4hdbtnSpbSRZnCvTPHyAEAxaIsXkOIQeiPuxOC3pWWM9B/HFYhN
 cv+F/rvy1eJgR4gJfcJNiohITf8u+fRMG/sUrqqo0V75U6GgJUCnVEG3OvAdqiKI8lBJ
 EgVA==
X-Gm-Message-State: AJcUukcAd7yTWqTXUiqg4r0Cb15G5cu3XPYq9LaNWMu+z5nWxzhiMlfr
 1iMjnxVw9tbZ352Harzg7Q==
X-Google-Smtp-Source: ALg8bN7Y5g2FaX5SHmq2tpvInGk0fAzgfe8q3egnt+r9F57nTKQ9k2JINHKPRc4ORkyL1tKYtWYn/w==
X-Received: by 2002:a05:6808:89:: with SMTP id
 s9mr10396347oic.131.1547237380583; 
 Fri, 11 Jan 2019 12:09:40 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id z191sm42879549oig.3.2019.01.11.12.09.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 12:09:39 -0800 (PST)
Date: Fri, 11 Jan 2019 14:09:39 -0600
From: Rob Herring <robh@kernel.org>
To: Jolly Shah <jolly.shah@xilinx.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: Add ZynqMP power domain
 bindings
Message-ID: <20190111200939.GA28260@bogus>
References: <1546638982-12954-1-git-send-email-jollys@xilinx.com>
 <1546638982-12954-2-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546638982-12954-2-git-send-email-jollys@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_120941_361539_1729BE21 
X-CRM114-Status: GOOD (  10.83  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Rajan Vaja <rajan.vaja@xilinx.com>, nava.manne@xilinx.com,
 michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
 Jolly Shah <jollys@xilinx.com>, rajanv@xilinx.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 4 Jan 2019 13:56:19 -0800, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Add documentation to describe ZynqMP power domain bindings.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  .../bindings/power/xlnx,zynqmp-genpd.txt           | 34 +++++++++++++++++++
>  include/dt-bindings/power/xlnx-zynqmp-power.h      | 39 ++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
>  create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
