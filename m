Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC68C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 10:47:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F1B221773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 10:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xh9x+DJz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gj8RW6Jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1B221773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wKXfNxScUpHAE3sZKppNi3NNYhb6mazd0ID1qpJGqII=; b=Xh9x+DJzEA7GGT
	HSPfRHAmhrs/wVYUmkb0BApGZfDoWc+c/zkAJnU/Jlhs8LtKK/HaRq4ytT1/ixl7er1XXkTKv9gr0
	3875CnJXrALNfosNidF3LCFQYN7FnK4PH2g3f4F5boMIcRaNqfkjchrsaN3LbgukD5Fm+8lNcEPof
	6nEbUJu1whImjrK4DCrbrONHBVu02DuY9zHIS1S08MUNrEx2rMYn8UFuXUXrULWQbOetxW+ukrQ4j
	ZeMxRdXzLXrGRxao7vgF1k6Pfb2nfvwrUKBijogz4G5mttzgje+JGZj7X6xtTXu2R7czBDvlcljsz
	5qbOYSHorHqK+KpBV8Nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqFJT-0002kv-Nr; Sun, 03 Feb 2019 10:47:47 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqFJP-0002kF-J9
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 10:47:45 +0000
Received: by mail-wr1-x441.google.com with SMTP id z3so440941wrv.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 02:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2oFjeI0j/c0fWIH9q7P4tOfETnpU6mMj5SgV/gv7eMo=;
 b=gj8RW6JvjXlGZA2nMGj95MdTDvvmvdBAEBBpxo9omiQhsMvRSSX4/3E1RV6tAfk8Zs
 ldUTXNEiEIdu3SeNgFOiILkixmSVKWvCAsHwf0Ja7JJAMcj2d8eNHCx8/sMOd1Vq/+Ow
 YmYd8MKH4tcLRge7rLpjS3RAkqsoRLwtZshjLAKfX1gwc6l75JMYAvOSH6I8pV4BphuA
 +r7gOJBkYC+jk2eUjBFYRyonGP374zLFdNf4Vgiu5Vf9mtV3BCmvLyaB8jFhXwjJ1laP
 qEs5LCgg+y51cbPJImNkXW6ZhL4wEp9iv7qQ8SeUVP0kTGnxsyEGCYjHovM7TzmeCHVz
 dzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2oFjeI0j/c0fWIH9q7P4tOfETnpU6mMj5SgV/gv7eMo=;
 b=bwfTY8oPECYS/qFHhBEop9j/Z677/hDXUX0klu0G6d9PmVQYJN/0ySP5nXyonRMUYn
 qV8AlI6ASrkLAIjQYDKAQ+kvrrdE3JdWucznvqvtcfAFftcBwAJMlNJUSFrk+wvFGOVO
 AdK7yF92lYZIoG9FTxDsHEdqypYjSkbzV7X0w6SqVsJAoqk7NFY7svm5B/e9ZKpa+UKp
 epEejBfYxnsOC4QALnim/YtAPovFZCBAUxd2AsbouOUi/Xj5HZ00Pnm89DEcXtvQ0sym
 u4I/pXZtyq1d1t+Pfb2Ug9/Zb8cri7j4oqGk6WvRzX939pwfcEzlQ8+774aa3AbBL6y5
 tspg==
X-Gm-Message-State: AHQUAuaBNhCLVEGW7r6rcl+nFGLv7ILzidY4ikoQUe1PHUQXUrqyEX76
 Hg9RicSjrcM2BcyjkGvrsT3U5Q==
X-Google-Smtp-Source: AHgI3IbOYPIibgyvxsOaUIEAVVMLabHQW5SKNW6m1FuLtW1EswHYkuyRKw3+j/ckYgithODTJMs2Bw==
X-Received: by 2002:a5d:6803:: with SMTP id w3mr7005601wru.272.1549190861330; 
 Sun, 03 Feb 2019 02:47:41 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net.
 [82.243.161.21])
 by smtp.googlemail.com with ESMTPSA id q12sm4702470wmf.2.2019.02.03.02.47.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 03 Feb 2019 02:47:40 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH] clk: meson: fix pll settings calculation with arm32
Date: Sun,  3 Feb 2019 11:47:16 +0100
Message-Id: <20190203104716.10479-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_024743_680777_F71854A1 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

fix undefined reference to `__aeabi_uldivmod' when dividing
u64 on arm32.

Fixes: 496c0462b46f ("clk: meson: pll: update driver for the g12a")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Neil,

 Feel free to squash this with the offending change. If you prefer,
 I can submit a v7.

 Cheers
 Jerome

 drivers/clk/meson/clk-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 7946d21a4ff4..41e16dd7272a 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -151,7 +151,7 @@ static unsigned int meson_clk_get_pll_range_m(unsigned long rate,
 	if (__pll_round_closest_mult(pll))
 		return DIV_ROUND_CLOSEST_ULL(val, parent_rate);
 
-	return val / parent_rate;
+	return div_u64(val,  parent_rate);
 }
 
 static int meson_clk_get_pll_range_index(unsigned long rate,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
