Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A9FC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:16:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F3A214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hxmsqSlL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY+QPL8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F3A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g9BXxWG0CTjpl4TCB6Sm9ayfkntFsDNrrWXvbxyvI/A=; b=hxmsqSlLh6yJDT
	W/Q1ek/57RqgrAitD+pfDrBNeRfPhaNtySG0lP7mIrv9qsJqCLkP38/qGawwX5Li4cQqWn/9clrCb
	TzBgiDnSxTjPzV5E5wuCN1AoxSofyQNtqd61Yjd/+qr5sV80OsBRousbibQsqtJPfBk2AqEanES5p
	K3/VFJcokIU1q3PtPhBiGnWJ30c69dndb1oD+m5Kl+uxl0vC/RhrDUlusZ+YNZ4Chv14f8j7qd/PL
	gwjXS0bq6hbWCGXrAdzXaXknROJSVeUF/xBl8ZsY0/6MM5ax/QwtQx0z97xPiiP9LSOsDor/a5PNi
	/FQGPivh6wNnv1/yHa1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqfyz-0004P2-DE; Mon, 04 Feb 2019 15:16:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqfyv-0004Gl-7T
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 15:16:24 +0000
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 79D35214DA
 for <linux-arm-kernel@lists.infradead.org>;
 Mon,  4 Feb 2019 15:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549293380;
 bh=0pqxl6izDyu/4SjeCOSt5eCkgS4E4c3y11DBXPBa5VU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=iY+QPL8K5NA5bJJQhVEdrc+igWFvWYjrVBrjdp5XxWnga+RvgblqtiA4d7wOvpZ+4
 968b1PaXQ+JHQkiDvJimvTSXweDSQsMCqKaXpW6GOqryRBeazSvzE5JHXXouBc5dMQ
 JdgJPdNbQiDR8ML4NqzKcd2hPm1LcM2WWU/7JkU8=
Received: by mail-qk1-f173.google.com with SMTP id o125so132469qkf.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 07:16:20 -0800 (PST)
X-Gm-Message-State: AJcUukccy7GBkJYCKa3poq+Hr7v3wKkCIKBXDT4Z6J2vBgqetAa04Rmp
 2N3Pvr6JsrtQDglHZb5zVJV/KuXzNtJ+B8KEJg==
X-Google-Smtp-Source: ALg8bN6XXnUKIMrpmiD9grXsHw9JigaEBKawUdOgXXEktI4BLoccbjDykbmuLx+YC9273YS1f6Dq+mglzP0PUK872r8=
X-Received: by 2002:a37:b646:: with SMTP id g67mr46978245qkf.326.1549293379667; 
 Mon, 04 Feb 2019 07:16:19 -0800 (PST)
MIME-Version: 1.0
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-16-linus.walleij@linaro.org>
In-Reply-To: <20190203214205.13594-16-linus.walleij@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 4 Feb 2019 09:16:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKEWtDN0VYwZaJqajcvomptbML_rQeBavh_kCYeVFZSPQ@mail.gmail.com>
Message-ID: <CAL_JsqKEWtDN0VYwZaJqajcvomptbML_rQeBavh_kCYeVFZSPQ@mail.gmail.com>
Subject: Re: [PATCH 15/17 v1] ARM: ixp4xx: Add DT bindings
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_071621_532991_0636B9F8 
X-CRM114-Status: GOOD (  16.75  )
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
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Tim Harvey <tharvey@gateworks.com>, Krzysztof Halasa <khalasa@piap.pl>,
 Olof Johansson <olof@lixom.net>, Imre Kaloz <kaloz@openwrt.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 3, 2019 at 3:42 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This adds initial device tree bindings for the IXP4xx machines.
> This time I tried something wild and crazy and try to make proper
> JSON-style YAML bindings for the top level.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I have no clear idea on how to auto-test this schema for validity,
> since it is a bit of a new thing I hope to figure it out as
> we go.

Is Documentation/devicetree/writing-schema.md missing something on how to?

The DT patchwork instance will have test results too, but in this case
it couldn't apply the patch since MAINTAINERS has a dependency...

> ---
>  .../devicetree/bindings/arm/intel-ixp4xx.yaml | 22 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml

In any case, the manual checker thinks this looks fine.

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
