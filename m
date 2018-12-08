Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFA5C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:20:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C2020857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gS8l9VbF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1F5pPuYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C2020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jgkXW0P8tCcSofiBjBx2LYMYQggcvmSqPVHU6Q8ymW4=; b=gS8l9VbFUUs0Fb
	8SDfdVwN4iN4qPizK49r3EVKz8MyBh6xQHqE1LGv/e0j2QybVOOkxTVVIhtpdTtpl+1YN9+nnx+jY
	7Yls3TaCrnlb13OJhQ4A2zTe4xG18Lsapb2ZMWsv971zHcLxa4INRTR2OOXanqBlBgCxiGKORPVmh
	e2+Rd63stmXV1KVWuGhQRZFeojSlyGg5jNni+1MFfOvp9U8ZDmU1+N5g+dZeyXK9kFwDT2iZ1W+71
	V0bqKUudNFWlSxRqGe2vTip7deAOm2L5c8k5QA91gHUV9UQfmDs+fj/pek6sSKCp7hjFRERsUM49F
	g2Qu7P1SzTL5l/VtyMHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVQLy-0002LP-80; Sat, 08 Dec 2018 00:20:18 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVQLv-0001YE-10
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 00:20:17 +0000
Received: by mail-pf1-x442.google.com with SMTP id y126so2680211pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 16:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=SsgzZB8Td4wE18SBCoqLu+DU0RtNakSEnvE92UOGK1Y=;
 b=1F5pPuYe/exeQ3rKR0koLTlvCmGwzBRT1GuQmpLVQH4jddBvzSjKW6zokwLsc2WwA/
 RKobYBd5rwoISH2t2RMJWdFJ/awmgX8/eFZlB+0Vadm++g/KvZtZ0pZ4RnLBePA38LuJ
 0jcqnTvT3CLFKVRB4YY6yb60PJtg9EViqrR68yX9JV38sO2tZnYez17uP7gRBnr+u2Tf
 dKluCHkoK1EXlAwJrs0NEX6vGTxrc30/A70mdHy9CCl5kP20u+xfSe2Ljv1dR/SmPxKK
 vvuBa+8AyAU7j4ZP9fKGCkOPKK7NvBE+zSExyW+hgYHzKtWP/Ld6rbhcRImuQLaGcp3J
 ljQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=SsgzZB8Td4wE18SBCoqLu+DU0RtNakSEnvE92UOGK1Y=;
 b=ibshKAeJqxbpoGxRmA0IONnGEeXGqhTlZEChXUR3kh7+EJfnnKy/1t4Po1sDi9Z2qX
 owMPlI47DT43xISsMpI+ZJYrAGL8VE8OKt3a2Ez3/da3kWfr1pgM5yyb/BZ2riXlNDxr
 Aa3omer/eznT8Mob23B7LnY9eQxDgFTQbeOkB+Oq/2nSQEBqR9oMhHE1UcfOX5cFTAuW
 kU3ulyvNa+J/gSqNXUMVaO/JycdFAx01Lun/AXQh3S2+tnKE5XJXppmv0AXxf9U0AYuU
 aY1KAjg4sS1JY8XtpfGsoigjI7gNWc774bPqequolewaiEpkEQ6U1ukgUublR0xrvT9c
 Hh2Q==
X-Gm-Message-State: AA+aEWZ8W+olAiBLgHhaRPenrgLI9RFGvzFP5r4LYHb5fgut1R7HgvbY
 G5gx7CrUeB1Y2jrwW6G9PT+oCQ==
X-Google-Smtp-Source: AFSGD/V+2uiF0J90CidJzrpNuOH8DO3AbXBgA9Ng2lhd04SvWXRjVfnrVYKjpbXFW4CUHv1fBGtxbw==
X-Received: by 2002:a63:561b:: with SMTP id k27mr3711928pgb.271.1544228403879; 
 Fri, 07 Dec 2018 16:20:03 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id c23sm5385274pfi.83.2018.12.07.16.20.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 16:20:03 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Carlo Caione <ccaione@baylibre.com>, robh+dt@kernel.org,
 mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 martin.blumenstingl@googlemail.com, ingrassia@epigenesys.com
Subject: Re: [PATCH v2 1/2] arm64: dts: meson: Fix IRQ trigger type for macirq
In-Reply-To: <20181207105231.25593-2-ccaione@baylibre.com>
References: <20181207105231.25593-1-ccaione@baylibre.com>
 <20181207105231.25593-2-ccaione@baylibre.com>
Date: Fri, 07 Dec 2018 16:20:02 -0800
Message-ID: <7hftv8yiml.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_162015_213720_AAFB5200 
X-CRM114-Status: GOOD (  13.65  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Carlo Caione <ccaione@baylibre.com> writes:

> A long running stress test on a custom board shipping an AXG SoCs and a
> Realtek RTL8211F PHY revealed that after a few hours the connection
> speed would drop drastically, from ~1000Mbps to ~3Mbps. At the same time
> the 'macirq' (eth0) IRQ would stop being triggered at all and as
> consequence the GMAC IRQs never ACKed.
>
> After a painful investigation the problem seemed to be due to a wrong
> defined IRQ type for the GMAC IRQ that should be LEVEL_HIGH instead of
> EDGE_RISING.
>
> The change in the macirq IRQ type also solved another long standing
> issue affecting this SoC/PHY where EEE was causing the network
> connection to die after stressing it with iperf3 (even though much
> sooner). It's now possible to remove the 'eee-broken-1000t' quirk as
> well.
>
> Fixes: feb3cbea0946 ("ARM64: dts: meson-gxbb-odroidc2: fix GbE tx link breakage")
> Fixes: 6d28d577510f ("ARM64: dts: meson-axg: fix ethernet stability issue")
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Queuing this one for v4.21 (dt64 branch)

I'm going to wait for the dust to settle on 'PATCH v2 2/2' for the
32-bit SoCs (and will rely on Martin's recommendation for the final
decision there.)

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
