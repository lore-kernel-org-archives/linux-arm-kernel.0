Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6904EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:53:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355372192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FxPHcm7Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2B2Lr2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355372192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=u02R3sRe2dHlq7u7QDHQc6vAmzkT5sXqvAhjuFXk/dE=; b=FxP
	Hcm7ZKoaPmSLLl0DXUOCvc3ufz2eihk3YdgCUEAn3etS1I6wVT+t12XUe/7xtWIR5y73JY8SrxZ6Y
	QprqgWoMCdol7QtX3APvQKvMfaVsN4q+mTilHbzQk5GZmSGCcilYqFd5nkzF1py9I8IhwUQjV2tyu
	4HB9wtkskp/pCzGuCYyJUh0/tlIHlzxnN2i0aCwwS2/dbeMbcwGkTc0c4SQqJWHS50a+GSnd6CVqo
	9dYTU5+gu1Knk+tbYwWHSb3RMoPYe90I6K7ZaHihbp2d47X0MKUiMWX7AtWCydlxo99Z4iLWrrCnV
	37CANf40SHgZkT8pcyJ3Dlf2YSqIROQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufoG-0006Ec-Jm; Fri, 15 Feb 2019 15:53:52 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufoD-0006E3-Iq
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:53:51 +0000
Received: by mail-pl1-x636.google.com with SMTP id e5so5143121plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=BNAyIQULOch2oxRm1MowAvaRc8wMMBA8HOdLECedo60=;
 b=U2B2Lr2wwDeSat1za8pMmL0TZD3gRiBVgsWjzLOkmtbLV0dMOTsxk4Phq2UCzNPC8B
 KJxiTN4WHBxfmFys2CkR1g2bshwzu7Oy+/AbnmUk6qUXTketl80JyNzoWJgyn/Cz5usA
 6s/sJ5b+sVYGcRMWLix+ofnzOrrKTMeNkFeqUF06mHwnNKbyV+Ft/qBjKX4S304QWHGS
 QnC9ix7iVc0hKrKl0O71fu8dnnQqVO6kWxIOV+2xi/xhG7cqiCX+hL8yUI/lXLac5eui
 w8sN+vvUnOQlLDFzALb4pAaNgLek94XRsLCWZw5KPXToVSc4jnvlb0QNAF5F8ooIxcAx
 WxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=BNAyIQULOch2oxRm1MowAvaRc8wMMBA8HOdLECedo60=;
 b=LRhE64cRLG7AXCNnMqNKSzwY7sAkJddAkchOY/mOa+uzmmeurT6my1eEzwPSFrBo33
 SroZhHVoM+r9y3OHa3DAe+xo4PIIm5WBh+iWc9E3qySinvksl8/nEWlOH9oUJGDshIGO
 gFgunSaksyjhtds5kHmMDHGc6jCqpFVJLY/VFROiiWTtCjCp/gs9eYsEWkYntli471hT
 0iQcOCBODw4yoYz00M1e47ogVI7M0UAifF6C44jvAMclK0LQ9O6YmIwPgnaNgN7Um76b
 lpLQG6SeYzViivmVf1meoIH9dFZichTNmtdWOOJwf9s9PxBAFtAgyl4DVNOiCvHmnFpX
 MBuQ==
X-Gm-Message-State: AHQUAubDoIUoGYdpzWPc6g9d+DU4zajTJ3ZTTjRMyfOzzY4MWks+FcUg
 DPW3JaBKDZl1gNjVhbILb1dMSA834Bo=
X-Google-Smtp-Source: AHgI3IYnGWxcjdzFWMa031Ut+5X47a7wz+L7Yiiv34Jv13ZlT1TFHkIhFD5mOq+cUb1691jtAJyt2w==
X-Received: by 2002:a17:902:9a09:: with SMTP id
 v9mr6444714plp.225.1550246028680; 
 Fri, 15 Feb 2019 07:53:48 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id v75sm10267969pfa.164.2019.02.15.07.53.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 07:53:48 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
 mark.rutland@arm.com
Subject: [PATCH v3 0/4] arm64: dts: allwinner: h6: Enable CPU DVFS(cpufreq)
Date: Fri, 15 Feb 2019 10:53:34 -0500
Message-Id: <20190215155338.10564-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_075349_618625_8549736E 
X-CRM114-Status: UNSURE (   8.31  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the cpufreq information of h6 to dts, source of information is as follows.

h6 cpu opp info:
https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/arm64/boot/dts/sunxi/sun50iw6p1.dtsi

axp805 spec:
http://linux-sunxi.org/images/b/bc/AXP805_Datasheet_V1.0_en.pdf

Yangtao Li (4):
  arm64: dts: allwinner: h6: orangepi: Add CPU supply regulator
  arm64: dts: allwinner: h6: pine: Add CPU supply regulator
  arm64: dts: allwinner: h6: Add clock to CPU cores
  arm64: dts: allwinner: h6: Add CPU Operating Performance Points table

---
v3:
-only update changelog between version 
v2:
-remove the opp of 1.8GHz
-update changelog

I tested the opp table on two H6 boards(with the same axp805 pmu),
but not the pine board or orangepi board.
---

 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  8 ++-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  8 ++-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 63 +++++++++++++++++++
 3 files changed, 75 insertions(+), 4 deletions(-)

-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
