Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D2FC2F42E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:30:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F782085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gSM1KpNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F782085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/1p+7xW4fYFAgrQqwx26TZoQTB3rPPh3Nzl7sLi9lxI=; b=gSM1KpNMgltGbq
	iSb+STuYBtaijuuIiRIYA+EsVG1MSiZfQJ3/PNCmMmFlFtDinS2Ro5BYOiEfYZyLsgMKQaRz2MFrR
	tzW68d6hqe9E35oagpTqoOofuFcFIvM3eJUZfl6vpfkNlEYD9PEE5kpfRq98qv+puP6C4oOnl8DsA
	iWlpcpf9Fi28lbDZL3d74rZkC4kDODUD6Z461w49VS11f285KuSDkaZOdbTBZnz+gJ+/457n1QKs+
	fG/IQBN9TRHkpYgAL/RCebL8+fFFS8PgpkMWlv+EslHGLK9vWtFKNRww/xCR2m0d+cLRam97x4fhx
	yNBfV1iTWN8iALjwyPcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbWp-0004Jq-7s; Mon, 21 Jan 2019 15:30:23 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbWl-0004J5-CA; Mon, 21 Jan 2019 15:30:20 +0000
Received: by mail-ot1-f65.google.com with SMTP id e12so20851376otl.5;
 Mon, 21 Jan 2019 07:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MGZmCsGV4ereTxx/nisevNb6yjZTfhF5rPIoDeCfGdI=;
 b=AeSG97AM4s0o84I4TJWyfyLCIX7nS+I/60tWpV8ulM5juKIDz7cYo+qcPvhrFT23ei
 048NggH9/hQ0pblk4ssou/KgthUoU7V3VA9ILEYszTvd5iSlJNSimB1g9jT2H8aubw21
 jKBOUfhqaXu6hdnWC3trp25Vdb4KzUyVqjbEZ2zkrjFtQG2fBva3oOiEp6EJQCXV+IAX
 zz8uSQSn3lVXxDARVHVNdjlvEcZvPkVMxIBNIv2NlL9Zxdlz0hiwjpgHVY5wXj2+8aD9
 lYZQuuI5cEeOxFojZ2nPO6y4tXESpuDvFBDWcaOyHSOqvvcEBGpd7ng5B+1LQ5C4U8Ba
 GttA==
X-Gm-Message-State: AJcUukebZTtq5v8wMzxd0ImsvMok2SK85vTebYdE8OPmfwraS+5RbOqi
 FekmcCOA9mtv+pwbe7bjAw==
X-Google-Smtp-Source: ALg8bN5tGpExEUlSOrUh6i94VTlkTi1/Rr8LsQL0OnEpbilq7cVPqoMdFFR9aqehARKlbM3Dnnd9BQ==
X-Received: by 2002:a9d:3d24:: with SMTP id a33mr20186193otc.365.1548084618386; 
 Mon, 21 Jan 2019 07:30:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id y25sm5481953otq.60.2019.01.21.07.30.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 07:30:17 -0800 (PST)
Date: Mon, 21 Jan 2019 09:30:17 -0600
From: Rob Herring <robh@kernel.org>
To: Pi-Hsun Shih <pihsun@chromium.org>
Subject: Re: [RFC v3 1/5] dt-bindings: Add a binding for Mediatek SCP
Message-ID: <20190121153017.GA4608@bogus>
References: <20190121071833.43443-1-pihsun@chromium.org>
 <20190121071833.43443-2-pihsun@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121071833.43443-2-pihsun@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_073019_413348_9D3C0941 
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>,
 Nicolas Boichat <drinkcat@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Erin Lo <erin.lo@mediatek.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Pi-Hsun Shih <pihsun@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 15:18:29 +0800, Pi-Hsun Shih wrote:
> From: Erin Lo <erin.lo@mediatek.com>
> 
> Add a DT binding documentation of SCP for the
> MT8183 SoC from Mediatek.
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
> Changes from v2:
>  - No change. I realized that for this patch series, there's no need to
>    add anything under the mt8183-scp node (neither the mt8183-rpmsg or
>    the cros-ec-rpmsg) for them to work, since mt8183-rpmsg is added
>    directly as a rproc_subdev by code, and cros-ec-rpmsg is dynamically
>    created by SCP name service.
> 
> Changes from v1:
>  - No change.
> ---
>  .../devicetree/bindings/remoteproc/mtk,scp.txt         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
