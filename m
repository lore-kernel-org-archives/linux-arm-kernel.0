Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C6BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:09:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F437217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bAmfSvkf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPhGCQrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F437217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kLfNAdzT+ttOudw5M2eA5KeuXQQHLmu6s+Ch/qq4VQk=; b=bAmfSvkfNix05K
	5c+nnwBcKOTNAFb073HsEcOGM/LiraRXSajOyErBLfwYBOJs2UlYzqYAKKVY5BN8KXgrOV+/+K9vQ
	U0P2eh5sXGnXUFMOj3esLJYQMSrOmtCNoaMCyeYn3hXEIPRmu0hV7NygfoFmbLYCJsKuLTzptdNF0
	DUTMHswofmE6PMWd8c5fIslIRfz4iGBe4K00yTKiJzcaSVWyaePPp0zzZTAVrcavUUQZYj/OZYP/M
	gQRZJ2olY3ViZvFY5bTYw2xE81LQ4wBAfnhnq/vCsXc2qj4+YhM7uLsx0uRceRvNkyNMfv1i/zW3r
	m9ZlH5rdrdaaREmhelXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7mh-0000FY-Tm; Fri, 08 Feb 2019 15:09:43 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7me-0000Ed-0V
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:09:41 +0000
Received: by mail-wr1-x434.google.com with SMTP id z18so3972005wrh.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 07:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8woiUdpmT/unzGKCTcasnjTUWRtbm57wdygkC9ImG5s=;
 b=BPhGCQrIO3vUe20ejaDfPm50j4zSih8OzMv6ZRaUPxrhCTSNnT16A9ac+OEftV8ZI1
 TUqf5MeABZsgSx3LOFjGko8TALlbhjLqUo5X6RwVbenbpezeq2e4JIyb5LtXE0Ua1H3m
 JUgj21P+JdjX1yo4Jel7wmyh19tz8fLOANBEsRdu3CsTOokqijUXlYV4iE0/67IundFd
 DfwL2IKaqu39S3SSG1i8/nu0KYZQ6eL9MoqEP+vR9cJkmgoVmfLwx+Lxvjtd0OWVY9LB
 xTu878VkHRa9SLXHLDjpMM2RuEv553YxaJwOrB62woeuFzMZbMtfNK5Ug42KjM8bi8Pq
 1wtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8woiUdpmT/unzGKCTcasnjTUWRtbm57wdygkC9ImG5s=;
 b=dLXmmZBOEol36XAv20Oz7Y7ZYDd9bqo9GPPa6i6fVPWxND2YQitzFsw8hC5pt3j38w
 E0mJI+em+tJzUNq6plF1ihjkcHAjUHGOQm356z8ytbpLSiOSicM/MWHuWpEgJANFLsD5
 tm/d72UFVSRjCT5XJbm48W58u3GZnPnhii65++/FdhISGdsE4dmIE19uFm/1i0UjbgiP
 /DJutV3dddlUkc507q8LMOENN6yKKd63SYCcEB5BCzICwozFkBZegQeRXRZ0/ZkRHmse
 Judp5A+QKPcU8nDMkNstZp1WQJLPt7q86+zf+3L6ghLyAWOppl1jhlK4ejH3z1//prrw
 bBYQ==
X-Gm-Message-State: AHQUAuadXZuFP/jDzkf48N9G3HWRGe50vbCCJ//R0tbJgh+9L7DKSPwp
 FHVK3Zp4ObakuyEoNrZm5Do=
X-Google-Smtp-Source: AHgI3IamY8GTA37ci2x+zGifULVUyi1FwOFGoIFwMUaJ9atltH2SOCTR4dzh9+dMi6+W4WikBfIFXg==
X-Received: by 2002:adf:e342:: with SMTP id n2mr16341497wrj.60.1549638577576; 
 Fri, 08 Feb 2019 07:09:37 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id d16sm1852621wru.52.2019.02.08.07.09.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 07:09:36 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 0/9] Tegra changes for v5.1-rc1
Date: Fri,  8 Feb 2019 16:09:26 +0100
Message-Id: <20190208150935.32108-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_070940_054235_1184CFC3 
X-CRM114-Status: UNSURE (   8.43  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SoC maintainers,

Slightly unusual for this release is that I've included two branches
that traditionally don't go through ARM SoC (clk and cpufreq). However
these are added here because they were part of a larger series to add
CPU frequency scaling support on Tegra210 and because the respective
maintainers agreed that it was a good idea to take these through ARM
SoC.

The dependencies between the branches are purely runtime dependencies,
so I haven't marked them as dependencies. They can be applied in any
order. This also means that if you'd rather not pull the requests for
clk and cpufreq, just let me know and I'll send them out to the
corresponding maintainers.

Thanks,
Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
