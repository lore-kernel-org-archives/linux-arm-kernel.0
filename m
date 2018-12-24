Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD319C64E79
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:02:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867EF2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G2ixV09E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YId/c6Kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867EF2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=qIM83JyYC9Z4JnH1MTXPem8fIgwmkwM21jS9Aw+CTis=; b=G2ixV09EKeUxok3Ju1Elb5BcYJ
	1FRrxacN7rmAUxzMCN6dbJs8kjLrFjU1CM68KFau2SLV+VYneTGC65LrBQndkqSuhVFoReO0HIYSS
	aX6GCeILmiuThLPFntxidV+tx24/1YW+RRbR/crn9hJSP65okDOzdDUs63lfSsgM20+2wUGkjI3US
	CMAfriWPj18Hy7St/VAe75cJvUQXPzxPHf4teTnt2O/tseBsDv+GyjZJezdckycLaeyR2Ra4kU2Uc
	VHDfvyAfB6myKC4SncwG+395kNsK8BlFIxBDcN0+7xKZMdzK64MP0keYXm/7zJX0mA3p5UKiqVdBt
	I1wsSIcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbYIs-0005Z5-KQ; Mon, 24 Dec 2018 22:02:26 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbYHe-0004Hn-1r
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 22:01:19 +0000
Received: by mail-wr1-x442.google.com with SMTP id t27so12538054wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 14:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=P0UBLz95gyX+HkR3MstEbdBikEcyR1+21JmSGtYW5Wo=;
 b=YId/c6KjXM301GLSJhWQkPK6Sl63LZ3wJ9GJNFHaz0Wmn517K9GkX7wTC77kyTD/mC
 txpLZsVo6pFDHtEKCG8gIRZPTEUNn6xNNmP5SD+8HElxQEV/0m2iypXNt5OjK4I2QN2i
 xluOXIzkyCGR6ibK0GJo98nIzPEYSS8UaAVI2buR3gfTxoYbm4D+AuE+5cNMrrISoGAq
 zvyaFs/iuu/gPcCWUQfuy2zoJOPqHtmvCvDX/g8kHkCiyLWCi7+z+ewvc6Oe8HBDikwv
 euUDU+kpSS71DkDgq7EX8IA+GrFZcVkrsQuyBjJJ0FzPZv+azirfLL5idMjksuuuhp2A
 BD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=P0UBLz95gyX+HkR3MstEbdBikEcyR1+21JmSGtYW5Wo=;
 b=f0tM7BKo83S2WiBbjUikpOyDxcixaOdJWZlDjtsSAbxLqkjcg6mClW1vj10w8L1SzO
 4K0Ksec2CaVG9RCizRA7pp0SuBhKiE+Nce//b5NcIaymvPjH8cub6FW+h77XLThE+1Vg
 O+DkKnO3w7Jpln1yKKvQgGDlVSor245NuUqcIjzOoJYsyqN5l2HITmJlcDoDukS1noIW
 chFpkAqEbDw48bGJPb0Il3UVFS+Uw1c3c9yASku4VpMcYIskJG5WTMajTLv+SDEDol8Z
 u3RxXU3PN7hbEdeZJjWGjE5BKUEYtFfmO/dUxkZZRDsHk4b8yqYZnf66p7fErmGMhXGX
 CDHg==
X-Gm-Message-State: AJcUukfmhlb4P8PHLqGJKEVlrIKLGA2QczBoQnDX/m4WledSnl/ZZkyb
 M0mSGkmMCSDOTr/UwbfFw5A=
X-Google-Smtp-Source: ALg8bN7MznKbxH3lPj/sc57JkKHfmTgO1k/K2yIWpHaOCRTp1d5Bo0H5hZR4d/Qnj6OO3x5+Ec7/0g==
X-Received: by 2002:a5d:454f:: with SMTP id p15mr13782204wrr.39.1545688860765; 
 Mon, 24 Dec 2018 14:01:00 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl.
 [83.23.22.20])
 by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.00.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 24 Dec 2018 14:01:00 -0800 (PST)
From: cezary.gapinski@gmail.com
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 05/14] spi: stm32: use explicit CPOL and CPHA mode bits
Date: Mon, 24 Dec 2018 23:00:31 +0100
Message-Id: <1545688840-23992-6-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_140110_492325_468CFACA 
X-CRM114-Status: GOOD (  13.58  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Cezary Gapinski <cezary.gapinski@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Driver supports SPI mode 0 to 3 not only the mode 3.
Use SPI_CPOL and SPI_CPHA indicates that these bits
can be changed to obtain modes 0 - 3.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 8310f14..f7056b7 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1142,7 +1142,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
 	master->bus_num = pdev->id;
-	master->mode_bits = SPI_MODE_3 | SPI_CS_HIGH | SPI_LSB_FIRST |
+	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST |
 			    SPI_3WIRE | SPI_LOOP;
 	master->bits_per_word_mask = stm32_spi_get_bpw_mask(spi);
 	master->max_speed_hz = spi->clk_rate / SPI_MBR_DIV_MIN;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
