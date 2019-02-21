Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252AEC00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:40:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C4E20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SgsFEwdM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0SanTzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C4E20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ox/zaWcB8vGWzGU0LFvXBvcc9e+YkRunvSlWUE4cRdQ=; b=SgsFEwdMkKJCh0
	Astu2E17Tbl+5Q3TJJnwGkLRHTLJDLCLetCVcnah4iX2Fn2dY3ki068YsegOfOVjzp3na+BSNkb14
	WNzctp1BNjLm61fLDCJinA9u28vlsxNKOSnd93hnvht58KbwfhxPxk2syPBZqRolzm+PGuYTZgQo/
	bqvXfwbzPmy6tVcsGlIdPHBKCGbHFSb4cbvGP6jfwLZHNU1ac3walqpkWNP3H+iBtOhOHdkyxCArh
	Md4J5K4DlvbEaWxV8dcJfrErAiYy5Ncj8TAZFH2MRdpKOY73kJwopwvnpccQAv0kuW18g/NZE94O3
	3H19dWkRJGNWuiIFhgDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gww53-0007We-Rr; Thu, 21 Feb 2019 21:40:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gww50-0007WF-Iu
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 21:40:31 +0000
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2A7B22084F
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 21:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550785230;
 bh=E4oo939D+Wd4k2cm0MMMJPASRD8zd2968+rhPegnv6M=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=i0SanTztlrA+RBfR/SuupafZ3fku56/vafXRVQOzbzaXz1LuSbYhsH0jw91SBHIna
 YOEwdG/LxVRQD/NZ44rdFDjLCkAGW9b31MFCLMOfyop1bZ3KkVOJXW7cgRgPyxSGID
 wxN1iFIKsbi4GZ1c904GxrfV2dnaEdSmjnrQod5w=
Received: by mail-qk1-f176.google.com with SMTP id o125so85035qkf.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 13:40:30 -0800 (PST)
X-Gm-Message-State: AHQUAuZ+CRqYHMUbMM3bxl7BjGH4DldAT+q9qjTY3jEMt/WF1l07+7bG
 ZoLutC9eak1spr92H2fX4u4HM04wco5n7gOG8g==
X-Google-Smtp-Source: AHgI3IbzkLbWet0saKWkUzUIFgRM5iGCk24Pr9PVH+ZqJWA0VHVe4BfcKwN6rCxKZfcOguJQjcLLwZZZ3ZTYQucUz60=
X-Received: by 2002:a37:a381:: with SMTP id m123mr536020qke.147.1550785229393; 
 Thu, 21 Feb 2019 13:40:29 -0800 (PST)
MIME-Version: 1.0
References: <20190221154458.23763-1-linus.walleij@linaro.org>
 <20190221154458.23763-12-linus.walleij@linaro.org>
In-Reply-To: <20190221154458.23763-12-linus.walleij@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 21 Feb 2019 15:40:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKp-DPkEQuWbeTsTqXF7v2=BD11-x2Os_8KfXtg28UJ8g@mail.gmail.com>
Message-ID: <CAL_JsqKp-DPkEQuWbeTsTqXF7v2=BD11-x2Os_8KfXtg28UJ8g@mail.gmail.com>
Subject: Re: [PATCH 11/30 v2] clocksource/drivers/ixp4xx: Add DT bindings
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_134030_641312_CB39A17E 
X-CRM114-Status: GOOD (  13.01  )
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
Cc: devicetree@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Krzysztof Halasa <khalasa@piap.pl>, Thomas Gleixner <tglx@linutronix.de>,
 Imre Kaloz <kaloz@openwrt.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 9:45 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This adds device tree bindings for the Intel IXP4xx
> timers.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Switch to JSON YAML schema, why not.
> - Not collecting any review tags as this changed a bit.
> ---
>  .../bindings/timer/intel,ixp4xx-timer.yaml    | 42 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
