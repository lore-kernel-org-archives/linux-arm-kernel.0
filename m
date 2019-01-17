Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3128C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:58:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8128020851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hUpzM01L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="l/3H2+Y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8128020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HB/OWqndr+0l7FlGjCBx7Mq4LyHtxZGwTr+bR7+Bayc=; b=hUpzM01LjBbymi
	84I0nRaUtH8tWiVaKVIPPMGTYW7SLkER7OGf2GOKALrv+Ah6ViJDAwhK0PzjtGv4qa1EIYa+25ZTs
	qEmEYo/MqxIT1UtE5wwMIGtQs1ypX1l4lfhGIY6Jnj4hyR1rJC1EPZ/PVrBd21A7wlomGUe/mpUPo
	mMg4aq18di7sJRF+chItn1ZYrvQzASIlucj9wJdWzRb+HuAPyTwn7x4Xs7we6lzfF4Xsr7pWD0umw
	y529YAeTIXRopvwvAJgZdpkNECQhZe/JrYg9TkzJLiO9Iw1wFRMTZYhWJGhCLkHqyOVS8rKfafu/c
	7eyBelNGMzqlD0ML9z0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkEjr-0005eC-7W; Thu, 17 Jan 2019 20:58:11 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkEjn-0005db-IA
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:58:09 +0000
Received: by mail-pl1-x642.google.com with SMTP id z23so5303891plo.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 12:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=FONDXt4AJS71zhG3kJTYtIF5wWChTZfEXF4/HXKEofg=;
 b=l/3H2+Y0/pOomsSjtHpSWzSHnVn90wsHBtZ6YGQMUu5OFV7ckMTMIGrdgZZOPMJ+Qa
 Xt5awjqXnrlSUtp9Tso8sIDjaFssG8Ffi5Srzqnade72ebse41WHYHFjS3EKdIes1Ukc
 JafNA2Rnh0GOfD7X0eQ1aA7Eqrx2unJHE/y7+lPOFxPFRH4IKabvEogjgRWldbxxoWSl
 Fxt1RpzwtU95c5e+HuN87kBmu8EjFmEjZGtOj1ci9uLpmxnD79FMzhugJU15VAN5GXuP
 HGAeRU/cgaVv0WBsXODnOproX3/ee9AYkamUy7ZDWRdRJlee5J4WkAfQGFGwfBG5ftFU
 1IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=FONDXt4AJS71zhG3kJTYtIF5wWChTZfEXF4/HXKEofg=;
 b=kbXeeH7ktIS+osZu/04XrW89HJiF/HCfJHt5xTV3dYRJ92W+CzkjTKv0QyaoKGM9Lh
 8T8MJ5mhIZIbTUg1o9tJFthvYFWtUhRwazZRic/P8Eu49mSmck7VAJgHIuxM/cu8poBy
 in6Gs11qAsldui16lw81f7t1c0mDbg6ZwirXNssS+r5tPTiTfqd7m8kc0WyfqKsdzb5o
 +uKKa60BeXsF5pnpGVF1FFIXebeFVkJ9UmKONXPp/SzEp+Luafv191Qw+Y7BEwgTucX8
 WVptp8outeLvwM/Yb8gUMKdiYQ4u7lZbTMBcsRg0RTKNfV9d+zrGjVG1J1gj9sB0UPVr
 JPhQ==
X-Gm-Message-State: AJcUukcj1T4JptOC7NIy9mMzQki6qIqz5DUaHo4LkECNJKClJkxg1lfI
 OiencNLEg84rxss5Hu5y/4QnQA==
X-Google-Smtp-Source: ALg8bN5aJPz/0qz25QK1e0Bf+RKkhytaFVzqGtNKMEpBqgbfHLnDVHH4Opvkd9clxBs5N8COF5GkmQ==
X-Received: by 2002:a17:902:c85:: with SMTP id
 5mr16744477plt.339.1547758685505; 
 Thu, 17 Jan 2019 12:58:05 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:e076:9fe9:59e2:1e0b])
 by smtp.googlemail.com with ESMTPSA id h128sm4172909pgc.15.2019.01.17.12.58.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jan 2019 12:58:04 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Maxime Jourdan <mjourdan@baylibre.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] arm64: dts: meson: add simple-framebuffer nodes
In-Reply-To: <20190116124030.16882-1-mjourdan@baylibre.com>
References: <20190116124030.16882-1-mjourdan@baylibre.com>
Date: Thu, 17 Jan 2019 12:58:04 -0800
Message-ID: <7hfttratnn.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_125807_605670_28143416 
X-CRM114-Status: UNSURE (   9.80  )
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
Cc: Maxime Jourdan <mjourdan@baylibre.com>, Rob Herring <robh@kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Maxime Jourdan <mjourdan@baylibre.com> writes:

> This patch series adds support for simplefb for the GXBB and GXL chips.
>
> simple-framebuffer allows sharing a framebuffer already setup by the
> firmware to the kernel for a seamless boot transition.
>
> It goes along with a u-boot patch series adding display support to
> GXBB & GXL [3].
>

Queued for v5.1 (branch: v5.1/dt64)

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
