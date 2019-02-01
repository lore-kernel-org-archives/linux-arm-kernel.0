Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889DBC282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:39:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA4F218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VcWVY2AJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQ7IshS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA4F218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=rPmb1XDkeKgogu7ZvdzdV9UhL6qwQAUG7uEzuydZFQQ=; b=VcW
	VY2AJbmSiiZ3l3UL07/b4DWk08sJmuKc1FptgB0AeqkzgGJ7tEKoRh0u29sglmbs82OcLBcGMU2P5
	2FUvROfRqlOECrm78PBr00V1BnC5VrAmYwXu4nJh7xPmI7iuawrkxNZuYzJX4IZ9gf0trUD8EBpZD
	T5ppk4+yJCJkkUGIpp5O6IRaD0XW82Ge6I16El5XVSCqDXQl43yMXhFt7zoe+V9Eo1PSv+tb6P9TU
	o9nB85vpva8my+YtGDtEAdSX0OgueUptFInFPcpyQQq7nu0gZ9dmxE61CuVSSHt+KN2DcWC1UlFtH
	OawLgTP/wjcM/B5lh65c/rIu98lpCmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpauE-0007fG-GF; Fri, 01 Feb 2019 15:39:02 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpauB-0007en-6k
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:39:00 +0000
Received: by mail-pl1-x644.google.com with SMTP id p4so108311plq.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=3NTv5eHd28mLCpqTEB1R7+7g3e4rlfMjMSD3f2Dc//A=;
 b=OQ7IshS1vh2MyN6bnmPd41J15BQEYSEsas9mRLTYWMaNH7KejRPcHc3AEI72ZThfPH
 0e+hn3p88HsjXYUHTLIRujNcqcD3GwH0yFxw0d8855EAFS3R0wZQ18gTyXmo8tyxx4z8
 +X0hD5zoFvVOuM4xadpYChNckWIldSZyrqI8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3NTv5eHd28mLCpqTEB1R7+7g3e4rlfMjMSD3f2Dc//A=;
 b=bSATUEfKT8qxAyRbdWNe/cmsaGYxHlcwFlmYLbpUA26EqZf4AdO4j+MlcPyXwe5v8/
 KhrWuBCtJsIGazH7q+NsjZ+mmZT3hroP5xwv19uiR0eI046MGZhc9vj2B1/2V04Cs5A4
 C1pVzceeXukXxR+PkhC95dmbS+qGhuv0k7ioYgwIw7ySb492gNVMpsF7MKCPjvv7JX9G
 8pP8Y+rOcCsY7hfy5hF10HQZjy9tl0kKruNiY9QNWGQ1TWn3NknJLIwFAXnl9tOwfDTW
 E9hRUy+UpwIKCHOPDllVfrSF90HvJnsieWmBgyORcR5hfRj6WhpjAdK8yeo+XSxx/dtH
 93hQ==
X-Gm-Message-State: AJcUukf9+mI+ioqZ6B3V+H3zMvjWgd/eZ8uNkO5ddobd4tI1/0pJvv0E
 LmEgbsVta+BPibaeFsJNizpi
X-Google-Smtp-Source: ALg8bN6MFbgIMYeKqXUWMofngJPgyLZiFAw9uaV5ssz3uxqpyNVTWZUYrEfrNEWeVvV9WMcGinvLvg==
X-Received: by 2002:a17:902:b707:: with SMTP id
 d7mr38120490pls.29.1549035538080; 
 Fri, 01 Feb 2019 07:38:58 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7348:9f93:3db9:68de:e3db:c028])
 by smtp.gmail.com with ESMTPSA id l22sm12350035pfj.179.2019.02.01.07.38.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:38:57 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: p.zabel@pengutronix.de,
	xuwei5@hisilicon.com,
	robh+dt@kernel.org
Subject: [PATCH 0/3] Add Reset controller support for HI3670 SoC
Date: Fri,  1 Feb 2019 21:08:38 +0530
Message-Id: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_073859_244099_D368F5BF 
X-CRM114-Status: GOOD (  11.05  )
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
Cc: devicetree@vger.kernel.org, guodong.xu@linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This patchset adds Reset controller support for HiSilicon HI3670 SoC.
HI3670 SoC is architecturally same as HI3660 SoC, hence the same driver
is reused.

This patchset has been tested on HiKey970 board.

Thanks,
Mani

Manivannan Sadhasivam (3):
  dt-bindings: reset: Add HI3670 reset controller binding
  arm64: dts: hisilicon: hi3670: Add reset controller support
  reset: hisilicon: Add HiSilicon HI3670 reset support

 .../devicetree/bindings/reset/hisilicon,hi3660-reset.txt    | 5 +++--
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi                   | 6 ++++++
 drivers/reset/hisilicon/reset-hi3660.c                      | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
