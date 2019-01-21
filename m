Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CEDC2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:15:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E81F20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P/ic0esJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rD6LLgSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E81F20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=uucsAKdgz4pHU/gGtr/ntAAceobjMduwEHS6HSwaPR0=; b=P/i
	c0esJi/YeUNDJFT0hpB4S10+vhBHzMbdYlRezZ27vb0AhXeCN5L6Q5Dmp7wnXFCX2S2OW4DPgvdlf
	j7g4uqZ3us3fyv1/aesCiyyyN2xZi0bOysWb/Ilj+XlQMRks8SQwglkZHQmKk14uI7A5hWhknOS1j
	D92aBUzgxUs/lxmbooAvF2+rSwdrhmHWUA3R8adtunjlc+BLB++x51mQKLcHIroFmoPhn8ypQbmBj
	g478Ff9YuNxINiMDIMmihJNdwCNrSHjRLxYNVVIOy+TS3lkbgfFTKYNDTCBPXvyTlOs8BAW52l2Ir
	9n32IDX8oCcXvSB5ETiMW4fju/T1u/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glcEZ-0003xw-Kk; Mon, 21 Jan 2019 16:15:35 +0000
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glcEW-0003wv-L0
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 16:15:34 +0000
Received: by mail-qk1-x742.google.com with SMTP id 68so12527768qke.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 08:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=84kAsmEVhaZVs53nKycwJOATMZtNr3mc+Cb51Mg2cnY=;
 b=rD6LLgSstvI0+mnzkKqlJ/LGslal8PB83QdgEfmWTgk+tX0i43/c5gvE1Qv9JPdpq9
 mavrZBfe13s/GZVEc9XhFfisofjCSha0JW9ZzXXDTSUIIsIJEAutRi0KA3wp+kDNLWeD
 2G2El7EXi3XvJ41gTNSaowLbI0Lw4h2EiyZiYoPG68yn0qQai/222IETf3tqSVCX059M
 wv/VxKnP1BlJIIB+HLMnzLYgiRUfS1G7BI1yoxLSpjsK9jdvto2utYewqaiRA3dck+Dh
 kcXmoSWIlDOYFr4SDL8b5breFGZfbuQq4D2XqmJRTEZ2MnIffge0jPBmsE6BmMo3+ECg
 BPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=84kAsmEVhaZVs53nKycwJOATMZtNr3mc+Cb51Mg2cnY=;
 b=r4BUyWEdWaaHbyfg5h4ELDA20kjKNko1w5p69ZEQbHZEZSzUQwgV5Tx0FXiMUH7yC3
 tTNzoGOMPT6uJFe1Nf2+ylNaPwMCcb9Eh98CAr9XWeWjWMDTSQX3QkOVohgA28wSJUwx
 CN9jPaoXyxFLGm03jowhIQE7G4LEnJJqKKzqE6lLpZXM0YGPssIDIElGFYERyC1GwyS2
 8odNP8UIP3/KSKQk1fcJnY/N8XXUbUXjDz+o5j0ZsyxqRGV8ViOTZgOi5IOh6ZWfPzjx
 pHXfmuwAjbmxzkveVJs2joNLrDEzUW50J6RtsGTaw2/7ywFeSJGivogBfXMbwG23YL3w
 M+Sw==
X-Gm-Message-State: AJcUukdj6dz2boTuWEkq+nT/JoExv9mIMk9m/pIg3YjDot7k2oh/z7rC
 hYQFIGDRmhTLxz5GEJZ8/Sg=
X-Google-Smtp-Source: ALg8bN6+evHgtc9Aw5dEuMmBFiNTqb4CPZktn9jOMbWir+0JpVHNuSrLLFamA8K0eJ97eMdkyTW3CQ==
X-Received: by 2002:a37:a053:: with SMTP id j80mr25254276qke.277.1548087331328; 
 Mon, 21 Jan 2019 08:15:31 -0800 (PST)
Received: from fabio-Latitude-E5450.am.freescale.net ([2804:14c:482:a73::2])
 by smtp.gmail.com with ESMTPSA id v32sm85340236qta.37.2019.01.21.08.15.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 08:15:30 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH] MAINTAINERS: imx: Change Fabio's email address
Date: Mon, 21 Jan 2019 14:15:26 -0200
Message-Id: <20190121161526.30172-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_081532_809476_0E997541 
X-CRM114-Status: GOOD (  10.93  )
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
Cc: Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

I prefer to use my personal email address for kernel related work.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aaa41de462c6..a3d1222b81ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1542,7 +1542,7 @@ ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
 M:	Shawn Guo <shawnguo@kernel.org>
 M:	Sascha Hauer <s.hauer@pengutronix.de>
 R:	Pengutronix Kernel Team <kernel@pengutronix.de>
-R:	Fabio Estevam <fabio.estevam@nxp.com>
+R:	Fabio Estevam <festevam@gmail.com>
 R:	NXP Linux Team <linux-imx@nxp.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
