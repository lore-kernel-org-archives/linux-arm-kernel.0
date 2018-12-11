Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B1DC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:11:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D88820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MLae30Cx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CPSklXgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D88820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1b9SjCrOwFEc21qELLa0iV7obrF9Q3k7AGgjTrqVlzY=; b=MLae30Cxy8tL50
	eMzS7YWVEMbbjlViNRPfRfsBztrUBytaJlrVnmDBMgkQ/gZljEuGLK/EUnXgA5s3oODWtfq6+T63N
	PuahPWzPhRmgve3p8Zdd+cCSi0XiTy/BwM5Q/wSl9+yxnj1yYCAKQrMMNrdE3rbSJcqMrcpsDzKyc
	Xv88euI7zd6z6j2UbG6DcihQf0SJml73zUp5jk7HN2i5Kh6Ljx2FljcbkjsVBwdk4zBWdPkJAuW0G
	9E0wd7NoO/coivV7mQH1eQTonaZN5fbcNfJudhk+DR3FsYsS4l+QtpjF5ESJA2RgAMbFVeUtiC3LW
	freO4uC8I45DDfZVKlOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWmUw-0002uc-V8; Tue, 11 Dec 2018 18:11:10 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWmUt-0002tI-Ge
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 18:11:09 +0000
Received: by mail-pl1-x62f.google.com with SMTP id gn14so7270596plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 10:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=+nLizEF7z4NjnZ1JylKcr/Fx20yPoJl7lV43p3WkXbU=;
 b=CPSklXgYVySFaBzc2d3/Puc9ptcmq8EAbw3El4CMrOboO76F13H+vW8DtvHAXSdPwY
 9ssjWCoHAYlMKk0sSRih1gSIHFi0DYj6L26zgHaQcbWyeWa+LaLuFcBy9jmTlVqYmUKV
 hWNTMkBw7+BVaSAajD37JN5n/deDen4Xscm6rzIKjvPZovOPTXaSiKobhDYfwWcJcAGL
 S35cK2Z0T9fAiKrzBO739PM4iMcia6HkwNqVm1w8LTn7t5OL837JtjC4o46sxAWzqAAP
 f77hK3H/yuDtaTp6E4rOLmzuG/cIqMo01tq/a+udpt4PI8oXtIGu+GvzDebg3duehKvG
 Ux2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=+nLizEF7z4NjnZ1JylKcr/Fx20yPoJl7lV43p3WkXbU=;
 b=c0ExDuOG+Xw5wmX69lZntBnP5P6KJqtCsQmmuLeWpt0Cr99p6/TAqM15bXb5jUxk1F
 NAGgPqzeHZq9bGOa3ZZ9JjSpm2rNskVi3g0W5CutqiUIUrRfYuJZD+ActyeB9EHA5JkS
 J5WOHivbkz5rnkGuaasS6zsfYII571+HX0XDgdJxGer+x41EXyzisGLXqo7AhwrJQU9e
 Ghugl7FwDig4JT5X5s4G1bLQBQqHvSmEcVDJD+YG6k2XnnrZsj/E6RCZUr1FxkjnwNPh
 yBIiSf90+G7wqhx7y0UAUQdDh9iYDRlrkPVZpaHSsomGaBlyb0oWHXGo3eD4Lzxs4ZMT
 TkSA==
X-Gm-Message-State: AA+aEWbbijhq89yswU71NrlTmr+M2aEdmH9Qli/40Wgf8kqAzL3Am0uW
 +8O3HReeq1RpmpagXBgpw34eUuZiRjA=
X-Google-Smtp-Source: AFSGD/W21CFPoJXuLEPkzAR5Nmzxf0nKjmvt7z6iYdlaU+K1y7psBODzjoesLoXjvsBA1OcADFBxlw==
X-Received: by 2002:a17:902:365:: with SMTP id
 92mr16088407pld.327.1544551856338; 
 Tue, 11 Dec 2018 10:10:56 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152]) by smtp.googlemail.com with ESMTPSA id
 125sm38058560pfd.124.2018.12.11.10.10.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 10:10:55 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / AVS: SmartReflex: Switch to SPDX Licence ID
In-Reply-To: <20181208160042.32587-1-nm@ti.com>
References: <20181208160042.32587-1-nm@ti.com>
Date: Tue, 11 Dec 2018 10:10:54 -0800
Message-ID: <7h4lbkue6p.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_101107_555717_B5B2883F 
X-CRM114-Status: UNSURE (   7.68  )
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
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> Fix up licensing to be inline with Linux conventions.
>
> Reported-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
