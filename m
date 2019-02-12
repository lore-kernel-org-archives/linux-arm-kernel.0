Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A8FC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:51:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4215A2080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LTp9u9Jz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcOD4IzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4215A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ht/2n/rQUGmBMI90SAvk40GfU/f37fJuh89+6bP3n10=; b=LTp9u9Jz1tvBo5
	HI6LDFifNHC2VTG9sFDZnADWUokMRFMSJCeHYtmx87uranZYvtlvqmb4J1tmTZ+818zb0/Cr1a8Jk
	20drQPNx5BFvtPsIqXeTt51D04MYc8B7FPTk6UW+s45a1r6lWWExq2ao6cujmdiKD4WqeTkfE86ue
	6Ism2XgAMdGFS6JXwjxy3WY9YwEQkr7PvBkEj1gCAFhzelnsOoNEo3AWmn/fOkMxHfnQV+k+GZeYZ
	jDSoBtJp3Io1BvDSJCiz/tR2J9clpsfaQ2Cy4XmNI8o+7fvgumcAGGa26m4B0VjRxH8GaOA8fW6Tp
	sgf2+sNVmSYwa1fNuYwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtNEM-0000gR-P1; Tue, 12 Feb 2019 01:51:26 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtNEJ-0000fU-Vj
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 01:51:25 +0000
Received: by mail-pf1-x435.google.com with SMTP id f132so468362pfa.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 17:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WWvbZPKYjHa1Sh3c2VYx3h0zBcjICrXwMR9K6Y7BuCg=;
 b=OcOD4IzSN7fQOL74FtDnchffPAylfBojpleBh1FtI6fCNLdZT/d2lGi/nIUKlDUbeb
 REeYd5c3UBgMchq56zPAXRDkOxKqRLcQqzk0l/KwCVnrMPPH6GytqEiKeOLzpgLvVMsP
 cnxLpJsaLDOdErY5AAQOPbipBQmrpEtzF7T5YcMoel8/FZaSfUM2YpfNAnZxtegwdJvx
 p8JQPFxqdRnmeWuXcnSGe1xNPLU65i1WHvLF/ZV9qrzY9B3tfdkJ/Exn8EpD4GCLiL3/
 +VmhxA2pfrC0ydc9KuLr65/5nocmQHPtBHq9tRk1j5eWr+VtVU0COwYm0QHt2an/5TMM
 X+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WWvbZPKYjHa1Sh3c2VYx3h0zBcjICrXwMR9K6Y7BuCg=;
 b=X810+bsg9qnpq5jGTa7F61X9f7j0oi0FgpIxtAbu01sz8DSDRIVuuXthfOIEtPgHiV
 Or8b9/ap2N9iFjtHvuiWMYGnVAhWp61lq5oht6xfbW3cDAZJJbAdcpReWDnYKDL7SsZE
 nVkGznwUZtFCqM9OIq3v8e6l1wY5A7VQVvBFvzB6EiToCkxpUW99bcetKZsrRdWRDrjz
 3tFDjHKk0k0Lynr9kU0CGptkyc0EWXXrpd1Q/Xnxm8tXGUaOSRJrq+r9prShxHCF0HM2
 5mt61A99XV8c8oCnW3nvLERs1Fm4BVx73gnzECrbd9PN8DhgNwfZZRC4reyoIv6rfyO1
 0IYw==
X-Gm-Message-State: AHQUAuaRhMmNhRAE9JecOWbBo1r8Svx/ANKzUTFMI9+djtsY09JBdSTe
 kvEUog1moaVB42OlzTjP/+g=
X-Google-Smtp-Source: AHgI3Ia0F4vKw82kH44GS69Oo1c5662wVJeYMvY64EqwxW4xhO7r/ceJIpElfwYVZ3mNPQaFvP/Qyg==
X-Received: by 2002:a65:5cc4:: with SMTP id b4mr1199169pgt.365.1549936282354; 
 Mon, 11 Feb 2019 17:51:22 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id h64sm17146941pfc.142.2019.02.11.17.51.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 17:51:21 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 0/2] "pcie_aux" clock for i.MX8MQ
Date: Mon, 11 Feb 2019 17:51:06 -0800
Message-Id: <20190212015108.16952-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_175124_075259_3A26B4CA 
X-CRM114-Status: UNSURE (   8.47  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Lorenzo:

This small series adds code to control "pcie_aux" clock. This is an
oversight from original submission [pcie-imx8mq-v7], which was only
discovered once I submitted an RFC for corresponding DT changes going
via i.MX tree [imx-dt-rfc].

Thanks,
Andrey Smirnov

[imx-dt-rfc] https://lore.kernel.org/lkml/20190131204333.31846-1-andrew.smirnov@gmail.com
[pcie-imx8mq-v7] https://lore.kernel.org/lkml/20190202001523.12517-1-andrew.smirnov@gmail.com

Andrey Smirnov (2):
  dt-bindings: imx6q-pcie: Add "pcie_aux" clock for imx8mq
  PCI: imx6: Add code to request/control "pcie_aux" clock for i.MX8MQ

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt   |  4 ++++
 drivers/pci/controller/dwc/pci-imx6.c            | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
