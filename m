Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F805C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:12:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177162145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XJ2KcL5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177162145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VQbQAZVT9VdSwxTIOWh2DkRC07KUko+5FCP2K8t4wVg=; b=XJ2KcL5uQxlyqg
	dq/cc8xdMVEGn5mdknCB10i+AQQBP6ZH0PFVjYnzm5vcc++R+My4sRVXEMh9aC2eyDyVCKOit/OJO
	TZBBr4dKRRBXMNbDrU5t2RGR/vrwa5qp8wJVX1yQARXXFPUiLE9pJ671k9J5qPMOTci86gAaljMPa
	ZwQIVJCfdvvS77nESCvcDQo/LNCSXnKEYg0/4MXf4LaaQLf48xbhRq+A6H3Sfe0CGmuYtvqeQ946X
	mnXWrAwUy/W2QxPEjXSLtVjWMho5AVqDP4K2yj8BolnO999xowODB6MUbv9/3BEbzyEu9SsNyGg61
	T5KaDhZE4D85K7vtThJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlCu-0005km-86; Mon, 03 Dec 2018 10:12:04 +0000
Received: from mail-ed1-f65.google.com ([209.85.208.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlCr-0005kQ-0R
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:12:02 +0000
Received: by mail-ed1-f65.google.com with SMTP id x30so10219698edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xRjBFh85MQbS2a8FAsvDnRi2kJOiNyC74NfxuA+bUGk=;
 b=DLJey4VwoIBsDkV2YUlF5dcJuHhBlmSvI52rZAReRUGs/IQVZoWs24VEX0/SEB0Jsa
 be3zY/zzqIVon/mSz3PyF47MoXEhaL7N727TTbvcxD4QIbK5eW53uKYnxE5oycDTvLfs
 1cc+nmWGAOX39B8eZBaEmd7ZScPwOYtDoeArx5ulPYdYNeyhoitRbiVYg1p/78OjwA59
 gdBo5dLE1NELDgkWpjlef/8bAiWG+xHOuVnVLVFYa9gDTC2c0fShsL4qssKa9Py94nVh
 TDr5QaCjIuLB9YfOIP3dIAoOszACJNUBqj4xzESXJ0fBWaLxb8pI4p/+DWYGTybNntdl
 CWdg==
X-Gm-Message-State: AA+aEWabalWkiO+6Ymk/JAlMTfcYo/NRuRco9VYvdJ+DA5GjEk3J2IlX
 DMwkXutGLsz5JCw78J7IFfyqtVRWDKg=
X-Google-Smtp-Source: AFSGD/XI6xP6hIcCagRXmH4oyjmuI6AnMFOOLV9pXLsNOmFQ8DT492LGh0UGcAhrAaPTcBsKcWejAA==
X-Received: by 2002:a17:906:404a:: with SMTP id
 y10-v6mr12433268ejj.30.1543831908245; 
 Mon, 03 Dec 2018 02:11:48 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com.
 [209.85.221.49])
 by smtp.gmail.com with ESMTPSA id i56sm3857459eda.37.2018.12.03.02.11.47
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:11:47 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id t27so11474527wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:11:47 -0800 (PST)
X-Received: by 2002:a5d:5208:: with SMTP id j8mr13937441wrv.188.1543831907353; 
 Mon, 03 Dec 2018 02:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20181203100747.16442-1-jagan@amarulasolutions.com>
 <20181203100747.16442-3-jagan@amarulasolutions.com>
In-Reply-To: <20181203100747.16442-3-jagan@amarulasolutions.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 3 Dec 2018 18:11:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v66pG0kes1_xBNUj4z85fjunjP_Fe5_pPiRja=nDSOS01A@mail.gmail.com>
Message-ID: <CAGb2v66pG0kes1_xBNUj4z85fjunjP_Fe5_pPiRja=nDSOS01A@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: media: sun6i: Add vcc-csi supply property
To: Jagan Teki <jagan@amarulasolutions.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_021201_047558_05714EB1 
X-CRM114-Status: GOOD (  11.94  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 6:08 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Most of the Allwinner A64 CSI controllers are supply with
> VCC-PE pin. which need to supply for some of the boards to
> trigger the power.
>
> So, document the supply property as vcc-csi so-that the required
> board can eable it via device tree.
>
> Used vcc-csi instead of vcc-pe to have better naming convention
> wrt other controller pin supplies.

This is not related to the CSI controller. It belongs in the pin
controller, but that has its own set of problems like possible
circular dependencies.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
