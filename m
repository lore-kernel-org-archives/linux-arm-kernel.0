Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7F3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:29:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1EE32073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tb+rsJw3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="GrBWxcGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EE32073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oLS05EgB/frSxHkaA4507x9+VBS0GE/al/l6weTcTBg=; b=tb+rsJw3oYWL12
	+JII1OhGPikdX1LeQfDnO87qBDrtv/S6forA1kH0S44pooqJsaveG3HwgOOOXP4IiMour75Tco6ah
	EkrWogXIMRaH470ni7W9VJGfGw7RJhqWtZ3DKfbBYv7IyTIl7zIZvJ6yqNnP8cuUSywSKkNbS+jpK
	YE2wFNdcaFey3CN2RdoRTbpFLC3lGzllkRBEfb8UQRzU6aQRWIbSvfTuFSrVxi945/ct+OJ/u5TPl
	vYOHgx8SX3FjURcVbkm4S/sr+pVai+gKK+Z8PxEaTAfjSLG82TyxXFU+On89RTDA3uaA492dF37Pd
	IuxFLjNalEYvWEyFbR0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5Hu-0002dw-KC; Fri, 08 Feb 2019 12:29:46 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5Hd-0002PK-Bh
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:29:44 +0000
Received: by mail-wm1-x343.google.com with SMTP id v26so3197243wmh.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 04:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AwlcFdNjaArFQK8VuUiv2qmrcfV52Mv3VLSBRqH+Mus=;
 b=GrBWxcGh8ewr9dq1wYM7qRBn63epekM+GjcGLDYwXEbTlOjwPFJazeRfwVyLG/sopM
 +eZQ7SWw3mK2z6KPrgHLQ6RWDbrM+GEfNCGwdXGDd79pjp5eyz172VUGcuDKqkUhRcuG
 UuTtXCK+XP1fW+VlrUY8GD3kAQf3TWvzk5eJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AwlcFdNjaArFQK8VuUiv2qmrcfV52Mv3VLSBRqH+Mus=;
 b=geALZ3zjMs7FF5TSRYxzCprdipfbfcrq8y4rc1tR2wSiZBFybQUlwYKsGQLyRd3Zb1
 ninxH3zYvH0ZUF3fdOLUfI5g5z1o6/BdWNIqlW6XuYW/Gb8+ZPjjRHwyNKz8j/RlPLza
 y/tpc3xIjyp6hLlBuCYkAilTjoKtuOxU6IJQYdn0VOR38Dywe6A4PqDWOpIpMr/ON4dI
 u1pSi7jS/80hddjFdkqeYi+Jsn3ql4l5w6xpBhUmWmj7de5JzaGY6j4/KDHLvHZZ016S
 92Ib1EXkHF/VqlXkfzHAyk5PRwYQOuSVe9ZTSLbt8G6p7L/N+b8Qi9Umy2igykEErqdr
 pSqQ==
X-Gm-Message-State: AHQUAuYyS3kGxQWBoMl3UNrjh8mgfLolNHUna6vBVwE2Itlvp/XTCsak
 G8rEA9i9dMHbnWC+UqnoUyW6bxdERgbpfLhSYWdANA==
X-Google-Smtp-Source: AHgI3IYlp7yU0kE+k2KeB3HVZRh00/3Hn72YIVu/3TLBHTsU2a3BbCYbbX3pl+gieVGIbg2sJ54KnXoIANXHeUlI0Mc=
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr11517169wmk.152.1549628966680; 
 Fri, 08 Feb 2019 04:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-16-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-16-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Fri, 8 Feb 2019 18:02:05 +0530
Message-ID: <CAFZiPx1KOCODT90oXd7+p3XwV8ujWae7WZtMbwtv_KDXB7nOKw@mail.gmail.com>
Subject: Re: [PATCHv3 15/27] dt-bindings: pci: mobiveil: change gpio_slave and
 apb_csr to optional
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_042929_847232_CF22BF5A 
X-CRM114-Status: GOOD (  14.86  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Xiaowei Bao <xiaowei.bao@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Mingkai Hu <mingkai.hu@nxp.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 1:40 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Change the "gpio_slave" and "apb_csr" to optional, the "gpio_slave"
> is not used in current code, and "apb_csr" is not used by some
> platforms.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Acked-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  Documentation/devicetree/bindings/pci/mobiveil-pcie.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> index a618d4787dd7..64156993e052 100644
> --- a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> @@ -10,8 +10,10 @@ Required properties:
>         interrupt source. The value must be 1.
>  - compatible: Should contain "mbvl,gpex40-pcie"
>  - reg: Should contain PCIe registers location and length
> +       Mandatory:
>         "config_axi_slave": PCIe controller registers
>         "csr_axi_slave"   : Bridge config registers
> +       Optional:
>         "gpio_slave"      : GPIO registers to control slot power
>         "apb_csr"         : MSI registers
>
> --
> 2.17.1
>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
