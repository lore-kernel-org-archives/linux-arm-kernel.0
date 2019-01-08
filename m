Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E645C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25FD12089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZAvMw+A9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="arFFNjky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FD12089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ggWB3FHA4Bp+rGsx8nJNPrlgIGFexAGISSMV7HWGwYk=; b=ZAvMw+A9A5u7pK
	CcadOJHy8ecNOWVuegVo10LesmBD8VoPqZ6+FMRcbvFkfM1zek+KY9aj0YNhnxFilV4PEIG5z/xZR
	wiqAEfyPKKxeO40H9+eVHANVrXDL8GlNZm9LcwITZCKsjL/7pZne8YFhN1oss6/YJl2Z7lLY8z43Q
	yiqmPZeSGxEgcpKDFOR7W+ZDOQyXvQfQ07/oHoPrNazfCg92JfKIHM7yKzBj4dG8Xsz1Trl/exYl8
	usESP75vIsQiCodoEnP3Nijn6WJzxl4TJNrvr5U+qhCPOpz7KqUIMGWOYTjuLwWVz6Jrz8/DaFdMC
	3C4/+pKC7Fb1mM0CF4IA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggnUm-0007P0-II; Tue, 08 Jan 2019 09:16:24 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggnUH-0006rQ-7V
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 09:15:54 +0000
Received: by mail-ed1-x542.google.com with SMTP id d39so3424284edb.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 01:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rzIOy5k8NvgMAGaMyhICjOaJC80/j9SQ1XPs3RN4Qj8=;
 b=arFFNjkyK5jgVqwI5Ncn+AX4a2Q/NGhSWf3He9mhz2NT/lv0JN6w2Fd6eObEZoLRYG
 VypoCMG+ieqP0BCnwTOuDhNKI0fl+vqoqjUIwqamttegNF1TUZKya0QRDNMuRq2TpLCU
 3JWsUClIg5p7i3lSu+oM6mhi6YH1grg3KEfwjuvOxOsvKAQAAfBuCsclNoCxdsaDhpjh
 1zydTjOEwKMHO2PYSy6IxNawqjaUg4kw/c2IPoBrghXUhWfHD6qFowNisM4+tyhpoVUV
 +7JYYq3T0ZMPwYYj59yt5py8VFcAEkul6t93PyeDqh4W55Z1rxJv0Zyi8mF1exbQeXML
 CzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rzIOy5k8NvgMAGaMyhICjOaJC80/j9SQ1XPs3RN4Qj8=;
 b=H6lkkpOCoJ9AMpWA7XMcGIzncnz5eW0Ctztx37SKFbpDvQg5DbSMSNrb65sRnrR8qR
 fTGeEd3MJo7mGEcCvv2vVJ8K3FKe90+C48Lpuwzuz+DEyAsaxCXNieIYFF4Qn6nyfv1G
 S4bsKOesYzTDOWmg0u+/c9Hlscyj+9Zyf5F1j+9F6qwxfWmACxTAL0EDrA4x7wc8MWiX
 9Afmx6On4lrViZ7jluMj4b0PjIvayBGvnJ1RCxEW8uJjBvD5uBhzLuJDRyxI08xyl46X
 8luv1Y5Eq1A6JuPWAZTUD+27uFe+5nrWnNy/RvTFBZp4STN5vnSPFBiObTtwgmzHir3k
 fdeg==
X-Gm-Message-State: AJcUukfQPMXVGgZTQWNtNjUIcENWPYeMuQj5gthwGugEeebsmxKtgh3l
 qn2saPPjfZX5hvPq/hKOsi4tcoVoC3VfqA==
X-Google-Smtp-Source: ALg8bN5D0lUcLdMnPkrhL+9/XqfcyVo0ZPm2mWRhm95c1UrmtVLn4SfcM8CGDAmsmNkCW55Cy8eMAA==
X-Received: by 2002:a50:b1db:: with SMTP id n27mr1317277edd.65.1546938951160; 
 Tue, 08 Jan 2019 01:15:51 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 01:15:50 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH 02/12] ARM: davinci: mityomapl138: don't read the MAC
 address from machine code
Date: Tue,  8 Jan 2019 10:15:29 +0100
Message-Id: <20190108091539.16674-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_011553_286904_4958988C 
X-CRM114-Status: GOOD (  11.53  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is now done by the emac driver using a registered nvmem cell.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 8df16e81b69e..3286dc2457a5 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -121,7 +121,6 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 {
 	int ret;
 	const char *partnum = NULL;
-	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
 	if (!IS_BUILTIN(CONFIG_NVMEM)) {
 		pr_warn("Factory Config not available without CONFIG_NVMEM\n");
@@ -147,13 +146,6 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 		goto bad_config;
 	}
 
-	pr_info("Found MAC = %pM\n", factory_config.mac);
-	if (is_valid_ether_addr(factory_config.mac))
-		memcpy(soc_info->emac_pdata->mac_addr,
-			factory_config.mac, ETH_ALEN);
-	else
-		pr_warn("Invalid MAC found in factory config block\n");
-
 	partnum = factory_config.partnum;
 	pr_info("Part Number = %s\n", partnum);
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
