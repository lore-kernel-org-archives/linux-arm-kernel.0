Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB22C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:18:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A38821783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CkZp57xU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A38821783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QUjzHx/xdvPijZCl8B1uTjlHOA1fWuECKjYJCu39Xv4=; b=CkZp57xUnWMLEY
	K6xD/h2z2/BYC+dbXRt48CkSa+jiGgKpdvLGpQJjolrk1pf4pl/6eemj0EcwFLyFvsSC1VnYoBfZ1
	qcUjv+v+IJQCFJ7Av25O4dDXk3qgXoapUI43dQ+aV/vn+tNtzQFqjvQ81Ds5NJXcZXfMtkHxx4ru/
	MiFDO6SQScH47tza5Yg8q5CbXniDogqRbNc0i4oskwFOM2vY5uHXkvAoGbK+/Z78C7uYJskupwk6+
	SrUu5l2ccVX8zI52TXXnxPiXNkIvnPQEJejrbkf58g7PPJoPw4PCssm74YDSRZ4QUrihcTetzHKQC
	j5RxXMS4gMpKuMrpvMaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ1D8-0007Rh-05; Mon, 17 Dec 2018 22:18:02 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ1D4-0007N0-Qa; Mon, 17 Dec 2018 22:18:00 +0000
Received: by mail-ot1-f66.google.com with SMTP id 32so13711096ota.12;
 Mon, 17 Dec 2018 14:17:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WdG2f+Px2LiQ52oY4wJmoWNSNC++xrWevzS1ytlkc6o=;
 b=lsIUXRdB3pqhyuId0re9njPieIHkiqoVdpo4/oGwREeNl96Qbg9nNfsKsqCkfMcNhP
 zL5k0HDvFbUWPlz+HMNSaCoB93QM2TmmOH2UCWyVvHGcx12KKMxoVg/YLUf78cHDBG/f
 NxKSba9MfoFEGXhcwAgTjEiGLnzHTcKt/kzWc30YSm8rdOO6rcsY7DPck4NK03Cx4uC8
 z1s3bo243gAGwgfMFa3wFsGfy85sjj7rWxMOc7uclVsiUV5kpTuXJa4gch6Ct9YXXSrZ
 RGrcpXjXExCHZxsPBxTN7ZY/GIs512Euixv9qRysyY0dj9PVA3D0ZoEhlKGA77deygUa
 ytFg==
X-Gm-Message-State: AA+aEWZAm1nwmJ19PViKASP4v0p/Q8SANYc4Drtjd/7d8LKh3AGEwZKi
 aqq5sl0j70oEKuqvWu8Liw==
X-Google-Smtp-Source: AFSGD/UwDLTGEhMD3EvUcf7gPTYetAM6f5a2hQcKlfnGe4hWm+gxZlxejA9Zl2Y1PdBB5mWuoy4qZQ==
X-Received: by 2002:a9d:4682:: with SMTP id z2mr10506153ote.104.1545085067864; 
 Mon, 17 Dec 2018 14:17:47 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com.
 [70.114.214.127])
 by smtp.gmail.com with ESMTPSA id a201sm7881864oii.27.2018.12.17.14.17.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Dec 2018 14:17:47 -0800 (PST)
Date: Mon, 17 Dec 2018 16:17:46 -0600
From: Rob Herring <robh@kernel.org>
To: Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v3 1/4] dt-bindings: i2c: Add S700 support for Actions
 Semi Soc's
Message-ID: <20181217221746.GA15941@bogus>
References: <20181211080448.24007-1-pn@denx.de>
 <20181211080448.24007-2-pn@denx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211080448.24007-2-pn@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_141758_879922_E7766B36 
X-CRM114-Status: GOOD (  10.05  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@cubietech.com,
 wsa@the-dreams.de, linux-actions@lists.infradead.org,
 linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com, robh+dt@kernel.org,
 linux-i2c@vger.kernel.org, manivannan.sadhasivam@linaro.org,
 Parthiban Nallathambi <pn@denx.de>, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 11 Dec 2018 09:04:45 +0100, Parthiban Nallathambi wrote:
> Add s700 compatible string to Actions Semi SoC dt-bindings.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-owl.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
