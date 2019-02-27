Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04A0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:10:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F814218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d3kV+ugz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKr02Ymg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F814218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UDgIXWBJBoHoM5h2isxhvb6hEJcfm4Y+w/Trw9J/3R8=; b=d3kV+ugzf83xys
	/OmOdRVsqy7I7DSGVOJ85xpBd0kPJmPt27XC54DK7C4K3Plm0n8r7Vx17xEV+h4EjOYvOBrdakoDV
	DvUDsv39RW8aXu5/jSGFruz19GvczDTTylkoymXs/qp/2iKs/QCkwFjeUJ8sMpsJpMslMpaPVr86e
	76tNF4hVukkX/In3tfS1llYMQspd7pswHlJMlWpmTJGkyfbzgXl9WKjVO6b6YJiHaECEphQHbRwEx
	LUB6mqgEl077e+cZVn60ImMl2uFttU+GtFqQ6a1xSfLWVdEoQhyhgk25K8O4k+pDnH+wnsXFfxmr1
	1Gcug7IeeHscFBbWVJMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gysPx-0000kG-AQ; Wed, 27 Feb 2019 06:10:09 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gysPu-00005m-3w
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 06:10:07 +0000
Received: by mail-pl1-x642.google.com with SMTP id c17so4289238plz.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 22:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mIBepAg0Yk/poa+mjvFR+U3FDg4po3CMCiCfsEn4UYI=;
 b=RKr02YmgXOuIxHVrrzJbGyjkSMPnLEMsm7plcDw1yO+dldAY2tbWbR7MkyIUIL6RDq
 FS2HoMwv9aHAiTjyjUtLhRzgl61ww8Iy22eVsuvawyqnfHKuXngjN1cRfEu1cT7qPf2g
 F/QuWg+ZDHWzrIxX3mGS0MFBvaopIAj2VHHWjZOhC+8bsnM/TDXSDpLLNdhsi1CiN+1C
 SLWUQbTLhkfUI0l9J2Ju/X0HZ8Ma86h87OdNdmUx72mJrA/AL+er1qleUY9DGlht8+R+
 dZi6azoTUUmHY9T4VjeVIRzV+h81sMzmYjKoN6jYT3fi8OM6AW697c7LfqBHk1B1uoRJ
 91Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mIBepAg0Yk/poa+mjvFR+U3FDg4po3CMCiCfsEn4UYI=;
 b=X/XDEvmTEV4iQSPjNGM+5AREH+o/PZSnjffCpxSVi3jmzi53Hr2S05F7GZ8Uvy+CIz
 SZWhXhrFi7xusmiueXN2RThcDVBjx/qd8Ry4a/ZQjuYk1wBUdOsAc14oAbXvjSPQ46tV
 7dmh7jbN7Q1vuAxI6qavSH43GcACue/Lf2FXNa2K5wP2ehvzY4eXCa63ThMvnOcAqKJZ
 Kx+s0z3mi05/XO3bu1aWMUTjqzNS5/7KSHyjtTSzh/FQsMmuILeuOBOyASkPEdHzWW8T
 tPo+dmycU4rtjdjdHYZCwCbiU/5lEbTvGLjabfRGpR6xKRRPwp4p+DLVo+KfDrF+KSBn
 nX+w==
X-Gm-Message-State: AHQUAubLogorPEePA3E5Kwp47WFkOi7d7iPjDQE9wnzDI+4CEhbvv2Oj
 Iru7VF5Tk/afWeokUg70o4c=
X-Google-Smtp-Source: AHgI3IYev6YCk5E1fIoIQRHGdXIMhcuySnlkS0OftHKJk8EpOAZFESazG/ogzW3I76JB1ir0QSCUnQ==
X-Received: by 2002:a17:902:2a89:: with SMTP id j9mr493155plb.28.1551247804713; 
 Tue, 26 Feb 2019 22:10:04 -0800 (PST)
Received: from bobby.hsd1.or.comcast.net ([2601:1c0:5501:37e2::87c4])
 by smtp.googlemail.com with ESMTPSA id d5sm20733473pfo.83.2019.02.26.22.10.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 22:10:04 -0800 (PST)
From: Robert Eshleman <bobbyeshleman@gmail.com>
To: bobbyeshleman@gmail.com
Subject: [PATCH 7/8] net: seeq: replace kmalloc / memset(,0) with kzalloc
Date: Tue, 26 Feb 2019 22:09:54 -0800
Message-Id: <5ff7bcf7b8db8daa129703e5f7b632825f25c766.1551246708.git.bobbyeshleman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1551246708.git.bobbyeshleman@gmail.com>
References: <cover.1551246708.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_221006_170339_846A9941 
X-CRM114-Status: GOOD (  13.82  )
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
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Tariq Toukan <tariqt@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch reduces a call to memset(,0) by replacing
a kmalloc call with a kzalloc call.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 drivers/net/ethernet/seeq/ether3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/seeq/ether3.c b/drivers/net/ethernet/seeq/ether3.c
index d1bb73bf9914..7456cf08a48f 100644
--- a/drivers/net/ethernet/seeq/ether3.c
+++ b/drivers/net/ethernet/seeq/ether3.c
@@ -223,7 +223,7 @@ ether3_addr(char *addr, struct expansion_card *ec)
 static int
 ether3_ramtest(struct net_device *dev, unsigned char byte)
 {
-	unsigned char *buffer = kmalloc(RX_END, GFP_KERNEL);
+	unsigned char *buffer = kzalloc(RX_END, GFP_KERNEL);
 	int i,ret = 0;
 	int max_errors = 4;
 	int bad = -1;
@@ -231,7 +231,6 @@ ether3_ramtest(struct net_device *dev, unsigned char byte)
 	if (!buffer)
 		return 1;
 
-	memset(buffer, byte, RX_END);
 	ether3_setbuffer(dev, buffer_write, 0);
 	ether3_writebuffer(dev, buffer, TX_END);
 	ether3_setbuffer(dev, buffer_write, RX_START);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
