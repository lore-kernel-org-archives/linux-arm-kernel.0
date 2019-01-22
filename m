Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC81C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:40:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A5F217F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y99U/k0Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xPxKI8Ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A5F217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RzKyGMapWvy6FdR6Lo2Qrpijifj8TCGFPGfjzUCnpOY=; b=Y99U/k0Z+Q1VUH
	K7q07br5hu07H2jc/JvXXKk/YgP74OItNcUgTqpWwu7++p4ejQ9mpkvxaMep2rMy+53L0DdS5xaSy
	k2jwTNHoQ0GmjSUKgBpmJ5u3g6oSUimUi+uFsWbzSDjG9rrAm43mcs1e1vbyx3rJZLi6Z0LM/1mhP
	a0L5DWo5plA+6gewGZeejpnfStlf9pjAaDG+m1+8HcCeiTf0yHzrjnESlAyhq4CTYBdD/dM/tC9Wi
	12ye+CZISoQpcCoPgTIOCLb0XZgXKd58oONqGEhBidg3usdrs3cB87m+htxwZ4898fWk2DtkHutqa
	IUHHB7w7KcYb7fPh6g3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glyA5-0005s8-JF; Tue, 22 Jan 2019 15:40:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glyA2-0005re-0i
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 15:40:23 +0000
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7769221848
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548171621;
 bh=nfH17g7hT3C9Ra5eF47HzQCPANsjsPbzv8xOYv+KqBo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=xPxKI8GeYoUaoGPJS3u2g5+oEGdE3U6OOyO+lmIoj4NP7nFS0eM7XPULZE47ilHC6
 px9+cGL8jU69J5pohvwtL3GlrsVuQ3MOtw8j3j7lif3EuxdzzsEZGs5SsM2GtwajOd
 a/31jOZ44VSVzqY2PdN330A17ma744Vh1n2FRO2U=
Received: by mail-qt1-f182.google.com with SMTP id e5so27966355qtr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 07:40:21 -0800 (PST)
X-Gm-Message-State: AJcUukeNepw94oSnmxQG50vK4eC8B8cg/M3GLwNQ500macgpW/YGZtCP
 0Sq1P4stZ0gE5YHbJFflw7u7qz60dHkP7vRCmA==
X-Google-Smtp-Source: ALg8bN6mlA+b5xNplGq7vMORmB9fivFFLm4qa0hifKph63t1Dja4m93gpfYxV1gsvx4LRwoSNfuWGx3VGQQqBOLziuY=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr30661287qta.38.1548171620633; 
 Tue, 22 Jan 2019 07:40:20 -0800 (PST)
MIME-Version: 1.0
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
 <20190122042147.5424-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190122042147.5424-2-manivannan.sadhasivam@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 22 Jan 2019 09:40:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJR6s-EPJdvvyY=v=0RRUzee2NBXyssgeY1-YYK-C4q3g@mail.gmail.com>
Message-ID: <CAL_JsqJR6s-EPJdvvyY=v=0RRUzee2NBXyssgeY1-YYK-C4q3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: arm: fsl: Fix bindings for LS1012A
 and LS1021A based boards
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_074022_078179_60806630 
X-CRM114-Status: GOOD (  10.66  )
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
Cc: devicetree@vger.kernel.org, a.tropschug@ebs-systart.com,
 m.bittner@ebs-systart.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, Yang-Leo Li <leoyang.li@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 10:22 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Fix devicetree bindings for Freescale LS1012A and LS1021A SoC based boards.
>
> Fixes: a1a38e1f4d1d ("dt-bindings: arm: Convert FSL board/soc bindings to json-schema")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
