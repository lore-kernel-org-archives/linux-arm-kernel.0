Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FDEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:34:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5953620851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="slY6oRgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5953620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7M9GztSHik7x7Fbsg/CiZA8A83lRM9Cr6vAFnZXtaOs=; b=slY6oRgGSlTEWF
	wHLmoJYrlNt7v8V7IGblSiQQjhMXQqncOZqA5wFw0B8P7szLqKB2I0/HdUh0bVQqMfQN8nn3B1b0Q
	UA0IspbTN8P8QSHNVhNFAHELqY6AsCg0Pw/6hVhAmCE99RR+HKWTamprVk2f1HCwpcSLNwp/s4v/W
	y/ZP09UF8E0Iurn2gdKL/tl4DMJSU3SG6ydYZxQQG6AaNwUW/qiX6fT7zos7L86apJpSUeAApPUoW
	UGpc8jB5xUIkTBP8+35I5O8q3qCy8S3kD/O5JF2L6nsXRKue13VZpTACw8/zm5CnTyIjHxQdX0Z+l
	T9EMDSEtqYNiOvuPF4ZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU8y1-0008Qh-Ak; Tue, 04 Dec 2018 11:34:17 +0000
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8xy-0008Pg-5q
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:34:15 +0000
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so14585078ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 03:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=D9Xfj5O6TrPCZ4XAaumYQKAYYnZ79yMVJdwXxt1b5i0=;
 b=lX9DTqI0lFwRJjTYm4D82p9qDRjeJNGuGRdmJT6ChNu4haNce06vZ5mlsIb1RvbEMW
 iOQi+WD11UyL+QEsZfC2QIHx+DXwk/hrNVzkWHJgB7qjhIzznUyilPzxsStiNeIzyR/e
 yVUhbplJrqZv67GkuLI6yY75V4VYE4B/7t6PGO9kFPQ+XTJfdG2ag54dpP9isZ6wvlPk
 KE40auFEysyXOD7hnBnesAusWb9k304lY/EYKxeZgoJEOgmPPVuofztflORHg90nCZTM
 EnixBzvyk81pj/xCGDmMAt00yZjXrvDYFGF7Rk4Uo31GICdT4o8drf3ufhuLk9x8hXx9
 c14g==
X-Gm-Message-State: AA+aEWZ/ujqVPIrHvrJAuJKCnQo+Q1z2TYxNJLWABONxdVx3PF606GKN
 EOJpXE8xvjzjCtRci5RAMVs=
X-Google-Smtp-Source: AFSGD/VfpVRI6uMyQNhr/c9FW6Ywud7OWk+oS7nf1VGsTMoPXyA5RaDpG1w+CiC52xYvr7CdcOSZ2Q==
X-Received: by 2002:a2e:88cf:: with SMTP id
 a15-v6mr12336777ljk.76.1543923242641; 
 Tue, 04 Dec 2018 03:34:02 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id g70-v6sm3120443ljg.92.2018.12.04.03.34.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 03:34:01 -0800 (PST)
Date: Tue, 4 Dec 2018 13:33:48 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH v6 02/10] clk: Add kerneldoc to managed of-provider interfaces
Message-ID: <dbbe1896ba62d2421606fb0807740d9e6090a1df.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_033414_213115_0D0780A7 
X-CRM114-Status: GOOD (  12.68  )
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
Cc: david.brown@linaro.org, linux-clk@vger.kernel.org, b.zolnierkie@samsung.com,
 sboyd@kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org, linux@armlinux.org.uk,
 krzk@kernel.org, akshu.agrawal@amd.com, cw00.choi@samsung.com,
 djkurtz@chromium.org, pavel@ucw.cz, pombredanne@nexb.com,
 andy.gross@linaro.org, andrew.smirnov@gmail.com, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Document the devm_of_clk_del_provider and the
devm_of_clk_add_hw_provider functions.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/clk.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index af011974d4ec..78c90913f987 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3893,6 +3893,17 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
 	of_clk_del_provider(*(struct device_node **)res);
 }
 
+/**
+ * devm_of_clk_add_hw_provider() - Managed clk provider node registration
+ * @dev: Device acting as the clock provider. Used for DT node and lifetime.
+ * @get: callback for decoding clk_hw
+ * @data: context pointer for @get callback.
+ *
+ * Returns 0 on success or an errno on failure.
+ *
+ * Registers clock provider for given device's node. Provider is automatically
+ * released at device exit.
+ */
 int devm_of_clk_add_hw_provider(struct device *dev,
 			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
 					      void *data),
@@ -3950,6 +3961,10 @@ static int devm_clk_provider_match(struct device *dev, void *res, void *data)
 	return *np == data;
 }
 
+/**
+ * devm_of_clk_del_provider() - Remove clock provider registered using devm
+ * @dev: Device to whose lifetime the clock provider was bound
+ */
 void devm_of_clk_del_provider(struct device *dev)
 {
 	int ret;
-- 
2.14.3

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
