Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E3AC10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:49:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02325208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dy3KgNkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02325208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xiC4sGcj0YphIdyXogTqet59ciTtGpfCMW3Bw6wUfO8=; b=Dy3KgNkweNjYYI
	StCp/7E45x0hftIWlo1QDEejljx3Lm+KTrMpSDfTFo8v/ipZTCn+xMPTwBQyGkkgFYrdvCLQAYhOc
	Y2+dUAV2Kv5D0mg9qrsjOCmXNLTAsAiq45ADlj8WGkKhgKBZkD58Ckp/rpnG9J0zT6/MwBa/ni/yn
	v0QCWRwMV47Rp98jnG4M9/6a8TvR0yeoJahzXL7cHsV4Aw0mODe/iZTLhCi0mpuN7x9dNQJZN6Fvm
	4H6jHOHMd3WTmApn8GF3rFDEGKqlyEHmRvhYi+gPmJP3pDFCgfx9v0MSJYtBMVCTwD/+IRmlScZOY
	eMRWrztjIwDM00sHr0NQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvouv-0001zK-S8; Mon, 18 Feb 2019 19:49:29 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvoud-0001iT-Mo
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:49:20 +0000
Received: by mail-ot1-f66.google.com with SMTP id b3so30271083otp.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 11:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vOK+4qtemVEZSOAnA8zIaao8MQOq+8sUNCoT3jozv2I=;
 b=i9v1LOf57tKydQnQBude/ysUIyGUzpkmQbm+eYV6RCsbntsUTm+JU/IGxP42wGwtxM
 S456JJVaBlt+fTjc2sUIgBl8B3uuDtpIcC8+/URaat198tEFuc31vQwf26WVwTdrCMDv
 RiIsGaY/l1Sl6HJvjZ1DigVA4P87+vyZybS8sZ6kmC2RarPjTBdZCRotUbe7pE05hNdD
 woTyHGPmOZJwX0CtCafwtt0G/jE4bBsM+EERfsQ5IR37vv8gS46iSZHOLtQRlws2Bmhd
 7n7xSDvJrHRgPlDPT4qjfH5bv+jvZg0/5XSLrbs/TN8Qm8bNgl/jRdAe9DPjZ98bTD2g
 4hIQ==
X-Gm-Message-State: AHQUAuZChpCBowmUqTebO0EiZYWaPcjg86gEBLyJ/GGurLDriHlWJ/fB
 Pj4HV3Um6S++zQRsAr0mfQ==
X-Google-Smtp-Source: AHgI3IbLJBtJMSXy6Td45k9NLFpSMoKE5Xz7D9T8jv/QYUf9cB/2luiAQUc04+2PeRthqP/tx48ALw==
X-Received: by 2002:a05:6830:104e:: with SMTP id
 b14mr1836646otp.250.1550519350685; 
 Mon, 18 Feb 2019 11:49:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id a12sm6322407otl.39.2019.02.18.11.49.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 11:49:10 -0800 (PST)
Date: Mon, 18 Feb 2019 13:49:09 -0600
From: Rob Herring <robh@kernel.org>
To: Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: Re: [PATCH v2 01/15] dt-bindings: sram: milbeaut: Add binding for
 Milbeaut smp-sram
Message-ID: <20190218194909.GA9552@bogus>
References: <1549628733-30171-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549628733-30171-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_114912_368352_61A05A45 
X-CRM114-Status: GOOD (  12.88  )
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
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Sugaya Taichi <sugaya.taichi@socionext.com>, linux-kernel@vger.kernel.org,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri,  8 Feb 2019 21:25:33 +0900, Sugaya Taichi wrote:
> The Milbeaut M10V SoC needs a part of sram for smp, so this adds the
> M10V sram compatible and binding.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../devicetree/bindings/sram/milbeaut-smp-sram.txt | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
