Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95298C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:24:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B263218FE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J93vSyQC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BFNfuLOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B263218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qyyOr3kkgFyuZMVF+zIijwf4JJqE8vYXrTbhAwIBI20=; b=J93vSyQCZZ4Zy3
	s7YnQyHXZLzUjykA8wtx0GmJv3ZQxDH/Y4sYyZGj7r2sJXrU2el/x19oS3c8F/vIUqSQ6djKnbgOO
	JvZs/Xg/od+2KfqJ3P+8M2Yzfv/kKkfR9RNnB6TTQqTdLeZhKnFJgFOcWAbthB71dMMSr1yoZEUaO
	bPN6uvmYH5nXQb5Daom/owLb7TxbFe4bXp4FfwmVNkTWFTI0KNKB8jVHzLvNh1EgCtAL8svG/ctmO
	4DsipNd1cQyM18AiSQphFA8b7pQUDqoIk4VokuucbK3fQL4r8AHNb+WZQRZZfD9TsGFm9qgWwXeIX
	bq92yNtEl1sSbZZzKTqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1graIC-0008IA-Mp; Thu, 07 Feb 2019 03:24:00 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1graI8-0008Gq-K4
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 03:23:57 +0000
Received: by mail-pl1-x644.google.com with SMTP id a14so4126437plm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 19:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=wgMLZtwbxS9Z4PMvknmxQ2RRO/mBgmvoLu3T0GddWLs=;
 b=BFNfuLOPpEVH0BDElhJ2FAyxVIWfcgPnbEtcK7Oomy7/5m0TiqFnBIU0mfaVIDjLi6
 SSqVW9ycop/cD8I0KsRZnRYuNZvnN4st5HheWG92DRCttgmmFR18OrVj6F1wtl/Hi247
 n9hAH5KNcaXZeaYuvyWammk3sBh7VoHy+2SnhX6sc4HCXASXeaIdNJx8wLznnuwzmuUH
 d8+/xuPBk1rDDF67aSwkzM9hiG4Kk7hrAdnbMDL6cYRe6B0KZt+hBM5o74YuBiMBup0c
 bqxWkMU9CKyrSWgMomYtUeaPlHaQ4zoF3N+6hNEXmnsg27Gl1y518ZNu0bbe+yAMhwPv
 N9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=wgMLZtwbxS9Z4PMvknmxQ2RRO/mBgmvoLu3T0GddWLs=;
 b=uPM3xyJWQSRAtrqo7rfmqEBRWMcc8m1gfTrVR6/H8iSoqXIagB8fA1B7TlsarKETrA
 adYU+YkcEygxXKOpPrOZZVTq3kGjTU2ZJoPphdSoCSPipQJ5+uxhSpOfryjgPkWh0iHW
 Jivc6sqMvf6YdRR8yd4i4Gnc8R9kspTm/stOHOktCnyuCA2rxryQiTkpSFNqtfPkpWQp
 8Y58CDX4v8NXD2PW2TMiWsFfTujfqHEd85fgcvcIYIN0O3+FGu5ouNLvI7KHypcu7+8i
 foHoIQ8BJrKkERQ28m0Busi4Qrm9Ul4eb0SC6uDvSOIDVOLpiWUNbYY7chToz632gXy0
 7gBA==
X-Gm-Message-State: AHQUAub0R3cs4tjQ66H0dIsHyhV5qsz/q38Icd5bckT0ULI21vak0OxG
 eA0dfgXSvOySDH6LYL5MhtOKvg==
X-Google-Smtp-Source: AHgI3IbSz0/OUlXHq1X8d1l7V6vht4CARVIl0WrRPaAxws7Kyb00C5LYas8twBs6xF7WOObcMFlvZg==
X-Received: by 2002:a17:902:24d:: with SMTP id
 71mr13857459plc.225.1549509834989; 
 Wed, 06 Feb 2019 19:23:54 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1818:ce94:f47:7c12])
 by smtp.googlemail.com with ESMTPSA id
 i72sm11363785pfe.181.2019.02.06.19.23.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 19:23:54 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2] arm64: dts: meson: fix g12a buses
In-Reply-To: <20190201133732.32169-1-jbrunet@baylibre.com>
References: <20190201133732.32169-1-jbrunet@baylibre.com>
Date: Wed, 06 Feb 2019 19:23:31 -0800
Message-ID: <7h5ztwi8ng.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_192356_656642_E9B3E863 
X-CRM114-Status: UNSURE (   7.15  )
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
Cc: devicetree@vger.kernel.org, Jianxin Pan <jianxin.pan@amlogic.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Fix apb, cbus, hiu and periph regions which are not aligned
> with the documentation and the information provided by Amlogic
>
> Fixes: 9c8c52f7cb4f ("arm64: dts: meson-g12a: add initial g12a s905d2 SoC DT support")
> Cc: Jianxin Pan <jianxin.pan@amlogic.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v5.1 (branch: v5.1/dt64)

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
