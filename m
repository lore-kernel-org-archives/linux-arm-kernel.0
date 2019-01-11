Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE2EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:08:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011962133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VYHHGczr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="T9MnGTy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011962133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UEjvjCnoFOPSrIxLDvs6dGeUr6T0K+yN2mgVsfGaxB0=; b=VYHHGczrY227z9
	RVoDfoEYyqpjECQ5xcD+CXzOm4G6PUXxuzJAytEfx/wuXqCRcKM8YvmFPkA4J8ZRk33cOSWNYAJ+4
	0YFPniS8TITnsq7gs3lQREkdrfXhIATIZrfiL7HBt621ShAPN1xGKIGbLRh1wjSCUZI4WtDf0u5hn
	LGviSJbOGkt2kgNzOHNVIf73OdYbRgFCFCYi22/QOoeRxBHLGts4zwsxvxDQ/eY81Lb1Fznv82c32
	Sk2YvuaSZddQoXOA9rnsEU97ThRC+CwW0v4t4/xoqoQuGNWDzdjo+JoqCW/fA3l7a+yrddz10Fzr5
	lxNR0DCocUxteOvNU/Fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghlJW-0000kJ-Qy; Fri, 11 Jan 2019 01:08:46 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghlJS-0000jZ-8J
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 01:08:44 +0000
Received: by mail-pg1-x544.google.com with SMTP id d72so5562851pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 17:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=omrSHaakBQsbB/LnK/odyGqedPA1JQ5CHxOtSmQjaSM=;
 b=T9MnGTy86PSj5UBUcPp0+N51sjWgrXoqoF74bex/td21khwS/dl9JyPRVkrD66f5gy
 WtFHsk2YymEmQDkDbzPhv56dn+J7W9+GHW8dpRVN4b+kmWxs4u2xMgjtkq0OeTrDxXql
 5k8EriKk+Uiswwl/fbSv0cFoAqTCHtfjeEChVncbtaV7RbY5yJ7xSt7o99NKc7Kxhdpf
 a3yp6Oa9N3mNmZp1bh7qnIIUYXJE/rDtpYgJi8QPuDaEUBTg6DJtaMWT5Y0pVud5OEoa
 QquaCM5zLhWcxNgf0615Lbh+EM2iwv5kthwQKWj1B9IviBYQ5Rs/qGL8mTzIiIVPWs3W
 WY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=omrSHaakBQsbB/LnK/odyGqedPA1JQ5CHxOtSmQjaSM=;
 b=d/wZ2r10wzlGm+y37+bCmICY3z3PgJzkROSxhyYMHsQhEUoW0b0iUbBgAVeucU79aP
 y+8g2LjIXzdzqZvTjedZibKrqhDx/3g7e6N2z8v3TuM4E0tiKa7TVtcpVeLfmnHz2GLC
 YRzmyLtX7YBG1YcBgVPMuL+hexQvOhvAP4E1FZkZr+zVJjKf8MNAbGNugX/OUWqkdvcM
 l3xyR9Uzyv85Vi6ZtjIGYOIFNOYQLbRS+ElkolihxpZQbHh6c9UP2dyUAHfysdvS4mR7
 2cZ4XwGxnRLj14jSfPSzk8UORTSS/NYisY4AET3zIQKm1QfIF7wEJn46kSa/IHkP2FaZ
 EvHw==
X-Gm-Message-State: AJcUukeW9bLnduK4JM8dbtuvtPmVv9bIYaDsAsDYmZASwusQtlJMkaQj
 i8yuOoeIhXmnefz2dlcAK+5Nyw==
X-Google-Smtp-Source: ALg8bN7y5nklKnLRrC6ybdW9uVJhfNg8m94rfFRfrMPJmZGg8SM+7AnoRW/ZaTeADy763CZDABqIvw==
X-Received: by 2002:a63:1f1c:: with SMTP id f28mr11529925pgf.193.1547168921043; 
 Thu, 10 Jan 2019 17:08:41 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152]) by smtp.googlemail.com with ESMTPSA id
 196sm303711824pfc.77.2019.01.10.17.08.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 17:08:40 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, ingrassia@epigenesys.com
Subject: Re: [PATCH v3 1/2] pinctrl: meson: meson8b: add the eth_rxd2 and
 eth_rxd3 pins
In-Reply-To: <20181229143556.27339-2-martin.blumenstingl@googlemail.com>
References: <20181229143556.27339-1-martin.blumenstingl@googlemail.com>
 <20181229143556.27339-2-martin.blumenstingl@googlemail.com>
Date: Thu, 10 Jan 2019 17:08:39 -0800
Message-ID: <7hzhs8ovag.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_170842_299339_5943B012 
X-CRM114-Status: UNSURE (   9.81  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org, jianxin.pan@amlogic.com,
 linus.luessing@c0d3.blue
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Gigabit Ethernet requires the Ethernet TXD0..3 and RXD0..3 data lines.
> Add the missing eth_rxd2 and eth_rxd3 definitions so we don't have to
> rely on the bootloader to set them up correctly.
>
> The vendor u-boot sources for Odroid-C1 use the following Ethernet
> pinmux configuration:
>   SET_CBUS_REG_MASK(PERIPHS_PIN_MUX_6, 0x3f4f);
>   SET_CBUS_REG_MASK(PERIPHS_PIN_MUX_7, 0xf00000);
> This translates to the following pin groups in the mainline kernel:
> - register 6 bit  0: eth_rxd1 (DIF_0_P)
> - register 6 bit  1: eth_rxd0 (DIF_0_N)
> - register 6 bit  2: eth_rx_dv (DIF_1_P)
> - register 6 bit  3: eth_rx_clk (DIF_1_N)
> - register 6 bit  6: eth_tx_en (DIF_3_P)
> - register 6 bit  8: eth_ref_clk (DIF_3_N)
> - register 6 bit  9: eth_mdc (DIF_4_P)
> - register 6 bit 10: eth_mdio_en (DIF_4_N)
> - register 6 bit 11: eth_tx_clk (GPIOH_9)
> - register 6 bit 12: eth_txd2 (GPIOH_8)
> - register 6 bit 13: eth_txd3 (GPIOH_7)
> - register 7 bit 20: eth_txd0_0 (GPIOH_6)
> - register 7 bit 21: eth_txd1_0 (GPIOH_5)
> - register 7 bit 22: eth_rxd3 (DIF_2_P)
> - register 7 bit 23: eth_rxd2 (DIF_2_N)
>
> All functions except eth_rxd2 and eth_rxd3 are already supported by the
> pinctrl-meson8b driver.
>
> Suggested-by: Jianxin Pan <jianxin.pan@amlogic.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
