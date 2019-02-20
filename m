Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAE0C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:34:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8422147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SuORV6S6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aUZj46IR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8422147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Kci+kJ8h+cp7buvLLMaK4CDKEdSN9d1HYgbHFe4iQIE=; b=SuO
	RV6S6vXqVH/r4xUJHdky3FoTZkmVUUGxlStAagXXK78tT4b5MrC319NkaxUTGHfYr4TOK/sWf5/gT
	SHhEDzdNnfsolboC/ye7LPN5521wJ5lELhQpikXegk4r4/GZK++wml8+o207i4nNiujd+Ig3572Pk
	QmpQLogtpmsUxzVnMc2ZYV8B2BhvIuBa3sgykN0MS9jPxcqKMs21noxoIxWvYjTMnRyu/fVou+4EV
	Qe+vYHBh6gFBN/630SjUWd+Epz0mYtp48eoBZLTYRzF5EhbB42fPUD6wQe5SXam5LZdGOjma4oteR
	vcwegWwgqR6QUKk3Eu7jf+6M+pKpp1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwUp2-0005Dg-SB; Wed, 20 Feb 2019 16:34:12 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwUoz-0005D0-2e
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 16:34:11 +0000
Received: by mail-pg1-x543.google.com with SMTP id s198so12127758pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 08:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=3BWkOhTkkswDxf0FP7V9XAIUNHK7O40ffyu257dAaTY=;
 b=aUZj46IRGnkuSkRUWj0nYxAonh1J6EkNT/y4rr1tH8pGk5NypxqYTuQGiYsPsE3XRv
 Xiy6pRLJSj5/nQb7W0v+t8CUqDDWUmxp4rXtpYRfEzdFihPrjgp/Vk3Lgn2SD0wr890M
 GMKL8YWs5Rh5PN6aofXra2UQZdazKe/2M+n6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3BWkOhTkkswDxf0FP7V9XAIUNHK7O40ffyu257dAaTY=;
 b=G2hqPWW4tYJ6cuNfDKxPBYCqYZkI5ZFGrU1ca8DCmdSKn8wsZc2eLt//DNfDcSMfuu
 0VxZjJJkKQ2Vc/yjWKvWroYtzirevmPfeTwgKOPmTT0seLoa8laQvAjqzC0sKHZzAINU
 lYxZHJ5V5j+Hq9RExXZWuNZsbCAiqjvZIAiaVAZ20rKa3s/WOumhX1mZC+OLNhpzlmQd
 Gl6yCrzO0Svm/+8VmGrCue3Nj9VL/2e9fxxMYA7dJyPExlkYj/j4i0cQO6YQjzZLc/Fv
 xQP+p9W/NwTglAOE+35H0aTauKO6fdEQ3sx5nfDRbS3ou6y3aHAdO+bDNucTqvbgVGXF
 Th/Q==
X-Gm-Message-State: AHQUAuYic9X3gz4K8x+rBRYneIm6mXDEuY9dT6a78XtlrXwBicKjdFP7
 N2ri+8KvVTlqKtTT2OthQXFF7g==
X-Google-Smtp-Source: AHgI3IYSJLYMwme1v91novIPjbuXRyKVN3exUtRlX5MVCQx7Vp2iq0J0P/Zkr5gUTDZGSw0ZY2F9Zw==
X-Received: by 2002:a62:9917:: with SMTP id d23mr36693549pfe.88.1550680447687; 
 Wed, 20 Feb 2019 08:34:07 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id t10sm26556717pfa.151.2019.02.20.08.34.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 20 Feb 2019 08:34:06 -0800 (PST)
From: Srinath Mannam <srinath.mannam@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Subject: [PATCH v3 0/2] Add IPROC PCIe new features
Date: Wed, 20 Feb 2019 22:03:53 +0530
Message-Id: <1550680435-9706-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_083409_131076_ECCD09C2 
X-CRM114-Status: UNSURE (   9.70  )
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
Cc: linux-pci@vger.kernel.org, Srinath Mannam <srinath.mannam@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch set extends support of new IPROC PCIe host controller features
 - Add CRS check using controller register status flags
 - Add outbound window mapping configuration for 32-bit I/O region

This patch set is based on Linux-5.0-rc2.

Changes from v2:
  - Based on Lorenzo Pieralisi comments, commit logs are expanded.

Changes from v1:
  - Addressed Bjorn Helgaas comments.
  - Removed set order mode patch from patchset.

Srinath Mannam (2):
  PCI: iproc: Add CRS check in config read
  PCI: iproc: Add outbound configuration for 32-bit I/O region

 drivers/pci/controller/pcie-iproc.c | 44 +++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
