Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7AEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:23:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AABE92089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XYN5h1Ky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AABE92089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=by839Bo8RzAG8mO2MWW3CVfN1eEDpCTWwPW9N6LyBB4=; b=XYN
	5h1Ky0FCEL6qiGzMS6LzJ2HQPloOO866y1qi/NdAyJjjcO+EkJGfwvEb2GtUdraAV6kRt6iusWT5o
	B4k4IsedKLD8m9gHPrI5SfgIWJimGuJK6JBw+SclpJKsT3Af9nW93ZuQxzYOfhr/qDbpNB1ByGUkn
	wh3157qV7Pj8niKhbQqMMrrcFm3fisqelLfhkGPzZhoTkxU74PDwUfmgvQpSUiDGkD3OHXSq7ZG1r
	0+TquNqIAhOkXmvcc67jqmNGctyGwYUVqAnK8uw3eqyXUSuaamC/U71eJehURb0bz98dInBzutXd4
	XfAl54naH+FV2OjCuhD9Uyf4+eMeHcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwA3J-000801-SZ; Tue, 19 Feb 2019 18:23:33 +0000
Received: from mout.kundenserver.de ([212.227.126.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwA3F-0007zd-R2
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 18:23:31 +0000
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N4i3j-1h4nHh3k19-011lyv; Tue, 19 Feb 2019 19:23:23 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Minas Harutyunyan <hminas@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] usb: dwc2: suppress confusing warnings on BCM2835
Date: Tue, 19 Feb 2019 19:22:54 +0100
Message-Id: <1550600574-3674-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:Wmsw4IzkjEm7D/4UJqHWMdmF2Qlg4io0U3aDsbZoSuTi1i6W05E
 heP0tXqCbeseip02VLOhxmJHvZxuecKQlcbXCOIcx83TxVMGuwXfFK5zErwoThgZRSuMfi0
 0kEqwypisjClqRHak0YzsTHMUBIAbdnvVLkz2v9GjHsXnSQy7pqvlWzZ8i4XcbzPCwfWaJo
 K3NDjGrM1MzeW5fcVzDqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yMbY9C20dEA=:HNxH+Ayk3K7xKBvB96HL8N
 dObXLzyPpYgo3Z30T4y2QUYaKe/jHztvrPrhZvNKmAstXaPTaqOeaWC2/Di/sHvQOxEBcKNk0
 BYnB/joA6xlrzwlq2evxt3YiusOHu8ZWS0LZLq6RRX7dAmA0AaoCXt83Gxe8VSBZYstglmn6o
 X9bSeO+bwOgIZIwTKJG68eWaiQkNOEF5DF5UJnzsEqhjzY48LiFcs4xlXa2o+UWeLI1ynXTOi
 uDn6b7GqRvZRej/YSfI32uUGJW7wNrn2JSZPHlWVX9dYZOb6THUa46Pxrdp5npVwIomJ5vlky
 6ix8R2YJsKTjI8iT5CxMydrLyE/mi740nw6TSUwi7UgeV5nouZlXRHBtMYhcr8FL/oSjzFBEc
 bGjlaq8lXVUzJb/H8uFAl0u2wOuZtLP/jrDOaSErTiTpaVCCQD+NO5apKXikLg+ZQFQAmH8z6
 00a6teyn6ecN0F8ud8pTWCE3yDQ/cLAVEuPDHkwHiTx2vauOvIQi1EM7EZJjcq8o5evvYkdyg
 exVTRSKJiroiFFNJ3gcP7r+qNJ1fxJ8Faq2RAxhs/3gcI0RhrNJ7TzYwUBSgTitctxhjKv1RM
 betu/Z3diSNvRw9PhJJqmMkGdcnu8ut9ROhEZGkoUa553HYHpO1rB+OKAWZb9mZo1cPdxfmyG
 p500CvwN7Sld7MySYFkSme/OLxk/ljt9flMyhGWtT/+RrlPDD6oluf31HYSloqEubhakXp3x1
 Sf+ZBDVaCpE0b6Gwbr96nxU2tO9zneL3Yr/l1bBqErjYmhzFHFjYxlfvHPs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_102330_178887_7FC05CC4 
X-CRM114-Status: UNSURE (   9.16  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Felipe Balbi <balbi@kernel.org>,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

According to the BCM2835 datasheet the used Synopsys IP isn't a LPM-capable
core. So disable these features and suppress these confusing warnings:

dwc2 3f980000.usb: dwc2_check_params: Invalid parameter lpm=1
dwc2 3f980000.usb: dwc2_check_params: Invalid parameter lpm_clock_gating=1
dwc2 3f980000.usb: dwc2_check_params: Invalid parameter besl=1
dwc2 3f980000.usb: dwc2_check_params: Invalid parameter hird_threshold_en=1

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/usb/dwc2/params.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 24ff5f2..a158abb 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -47,6 +47,10 @@ static void dwc2_set_bcm_params(struct dwc2_hsotg *hsotg)
 	p->max_transfer_size = 65535;
 	p->max_packet_count = 511;
 	p->ahbcfg = 0x10;
+	p->lpm = false;
+	p->lpm_clock_gating = false;
+	p->besl = false;
+	p->hird_threshold_en = false;
 }
 
 static void dwc2_set_his_params(struct dwc2_hsotg *hsotg)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
