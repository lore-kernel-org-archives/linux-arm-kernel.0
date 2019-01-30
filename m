Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B420C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:46:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8A2218D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oa9fppCb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqGsq6Qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8A2218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/o5nkT7VUWbqns/qLXgQ7d4xXmbk2t8jYdt/SDH2L2A=; b=Oa9fppCbDEvtsA
	kVpFI1FyaQTgiehGZnw0w4iNaVjPKGFCuVN21lMEk2U6aX/jImot+kU06gl/tTTq2BVVA8s57eKBu
	shwWo0ix452GKPZ4UAvgukriwgK5V42Nv9tpoyB0T/2enBb5ESbGSaK8RxcJ5CrtdeIm9ZYKiq+TF
	jbxUdo5GbJwJFf3YAC/vTadvdXJDhdelkAzmk+f25lpYBMe4tXeRbr6s6g1TC7yOUADlRiNhEQhZr
	kPyDo13mFWHasGQyYhpu+XAMSA9WIz9xKwgUmXY+nLjW9j52a4r7wiLeT1DoBKmwoCgJlcS1efs0O
	uf5pZ1X1u4Y1VPnM8bjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goycl-0000XP-HU; Wed, 30 Jan 2019 22:46:27 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goyci-0000WT-Va
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 22:46:26 +0000
Received: by mail-ot1-x343.google.com with SMTP id i20so1176811otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 14:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mg2YhfagRVrUxNfCl2To+A8sM/Flr3Rnugx6IiNTkro=;
 b=FqGsq6Qzoi2SpGOMcMFx85uxdJYVowHCDErDcf9I/F94gvaG240ANLheA88Q1fWgbX
 1eM53Uz1/zJihMq7c8+vE8GuoXQAvWy8ghC14JN4QuGwl58TOhysoFoR2P3bUUWgkbtq
 dl+291YFuGZ8kMtk3BCXAVmEbJxmoNBQAdb6CSuCrFdk3HaSIeotM+kAgqPJrC6uWLPz
 obd5cgmBhOApr83C/81MIlSA1IO0UIPkbyMNQjIxLZUfXHWz+eNclf7zi9P2VtQbQXIi
 +Cek+xC7Xne40LZwPisOZrVBeqyzejOH3bxs4ISNw7gkug5Lh8pYCs4Y+Mom7n4cWbfK
 us3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mg2YhfagRVrUxNfCl2To+A8sM/Flr3Rnugx6IiNTkro=;
 b=YwnJ/1hPe6MP2CroSsSjyoDIlCJ7WJ/YN+57KhHbj1JAfxw7p4Buo+QN5gY1YrPvTz
 kyfslCZPYYr6AwcieUz8nyvmRmltJNZZ5/S5sWJjOkHkwetyr9G9a3MNATvwaI914mt8
 jqSk9X5cb+bTlAlv4WFeSEbCjJh0hOmivrkm3j4cwQrLYPk/QOwhelbysZIwIzI9A61A
 2lHrymA/44SjqGOmhA0q/4a3z8VdkGUvnx2KuNmpysW3T6mWbNYoH1jOtjulpF+WASb5
 6fPz2SthYrXK32oW3jw/SCHYjWFuNWso849GZ8V4OGv2s0iK7oyvyUwpiKhOvQJCwwJT
 Htyw==
X-Gm-Message-State: AJcUukd75OE9OUo2rFRhlqJsOYyJCj3/aPy2pVBqJpOdbav6AVrfboL6
 /z0DVnaZw2YcTyvYU/kdBWFDrFojNrlM7OZfCkY=
X-Google-Smtp-Source: ALg8bN7NnC+7jRWGNlDsekjCP4/ytzdo9AsnTrdd7Fj5qZ9ZeJ4yGK71IAE/VmEtKFo3k1lHQSTKmfI4FsCeoZsVBUw=
X-Received: by 2002:a9d:721e:: with SMTP id u30mr24540483otj.203.1548888382471; 
 Wed, 30 Jan 2019 14:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20190130201725.18961-1-ccaione@baylibre.com>
In-Reply-To: <20190130201725.18961-1-ccaione@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 Jan 2019 20:46:10 -0200
Message-ID: <CAOMZO5AU8y1mf1DCMcJ6Y_AN_rP47jx1uVhj9pLRtgL6P70ksw@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8mq: Add missing M4 clocks
To: Carlo Caione <ccaione@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_144625_043250_BDA5126B 
X-CRM114-Status: UNSURE (   8.90  )
X-CRM114-Notice: Please train this message.
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-clk <linux-clk@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 6:17 PM Carlo Caione <ccaione@baylibre.com> wrote:
>
> The clocks list is missing the clocks for the the M4 core.

There is a repeated "the" in this phrase.

> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Reviewed-by: Fabio Esteva, <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
