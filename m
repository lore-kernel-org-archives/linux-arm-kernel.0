Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5525BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:11:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27D620863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KZdWo7K6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOJd9G22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27D620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RKYhSI11IROnNWkF8GAl0DAK6x7aNPznFgtXGT3PYMw=; b=KZdWo7K6wPU5tQ
	B85DmFLLNNSu1kL3SQHwmWfxyAla8Z2fxJzazCZiKG/i1nppTMeiVrOwk1n9zrM4vGTL9lXrRahPE
	7x+XsKftVX7MdV5nYa2il8fhzXdFaaS3Uof+UmyBtnAaolaQ9JKN2EpzDpTdzgjS/to2jlBjb7gst
	RbdRCLqk4ZaDA2b79+1NeNtLYxoP/5MxcoqU8ojR3sZA5WmMXHL9FGcPZXBxC1L/6cwf34814nESL
	7X37ucueRDvcKqVub+iMWHh1oViuzTm56a1qjVBK3ZF12GQphuj7HsVl3tHUtHRxlnU0Md6ZuFmxe
	Y9+6ceRCTz5/L6v0LnVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7nx-0002lV-1R; Fri, 08 Feb 2019 15:11:01 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7mk-0000HY-Q0
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:09:52 +0000
Received: by mail-wm1-x343.google.com with SMTP id r17so3731413wmh.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 07:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=STRawEDZ3aDbsHGnZgRbdYm2rLIbMG3DM92Sz7unDrg=;
 b=WOJd9G22Hhl6heWu4H3Vi+EW6iE78dTg7B8QN73iSe2lZpeW5qCBgZ3b2LXzjroG+0
 B/6j4O/7jhomie678ZO66h7D5iyg2/GrL+7caECtKpvCSijNu+ec2GzjYE2KYfxn24FC
 x6voyoyBbYc3YnjRnaen0ljxudz3HUhtNsIfFUIgkpPgYvxpOYbV/sNcta9LNFdfICYM
 Qyw438exFWx2UdWrQKqYRfAk2Ww4OQ3iJLOJx2VDvH4QABogmkgfmaIBZHz23SkME0Fu
 u1+tP3bqLWVQSWi5hddTxHI6pvwRzCjho/DgUCqiOTwMssC35XzclrWuuCZrClvvOjG/
 +Zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=STRawEDZ3aDbsHGnZgRbdYm2rLIbMG3DM92Sz7unDrg=;
 b=Va/YzJ0pm0Ni3nlO8cOp/UpLd8lU5BSF+Qri2TgYiKQNm/ucNmLJ8kUYiSfqYReeoj
 jR8o3weZ3ZOLo9OeoyUhKpySVaRAfQVUvzK7RDq8zVzoxjGbGRDvzeblffrXf3i2Q8gZ
 /loiGptg7Yl8yKWel0aZ4iw97PLp3NPdwDm9DynyYoCVuv6t/JHsEPnrry5TMEfr7ee/
 DNpYKbgEFEsX582qXhyRBEHFMkCDtP5p3654RHh9QmM6demc2tRHHk07d6/ICCS9HQNm
 aBPuN0+YbOTnpE341xNrK5MUHYfMOP5PjaNhLXH64HRA1g/5W04vv1Pz8iSf2sT9Gyg1
 nR5Q==
X-Gm-Message-State: AHQUAubd1Ws/bKToIIBuucEVk5phoX4+7zuOMLbUPcHHN56ywFeEDb/X
 ij/NCTX/u90oaECwmiJEdAo=
X-Google-Smtp-Source: AHgI3IZMyN+vMwbkuyRxHGcHx7Vl9SEPlsIZPGGwSFTT5Syb9UbdRTECGCmgrlgqh47gXwPFBItneQ==
X-Received: by 2002:a1c:b10a:: with SMTP id a10mr11625013wmf.148.1549638584992; 
 Fri, 08 Feb 2019 07:09:44 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id k3sm2186281wrm.7.2019.02.08.07.09.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 07:09:44 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 5/9] firmware: tegra: Changes for v5.1-rc1
Date: Fri,  8 Feb 2019 16:09:31 +0100
Message-Id: <20190208150935.32108-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190208150935.32108-1-thierry.reding@gmail.com>
References: <20190208150935.32108-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_070947_357592_0E19691F 
X-CRM114-Status: GOOD (  13.26  )
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

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-5.1-firmware

for you to fetch changes up to fe45ab552955ee93b492cbf86603eb02b3c77a66:

  firmware/tegra: Enable Tegra186 BPMP support on Tegra194 (2019-02-07 18:52:39 +0100)

Thanks,
Thierry

----------------------------------------------------------------
firmware: tegra: Changes for v5.1-rc1

These changes add support for BPMP on Tegra210.

----------------------------------------------------------------
Thierry Reding (3):
      firmware: tegra: bpmp-tegra186: Remove unused includes
      firmware: tegra: Conditionally support SoC generations
      firmware/tegra: Enable Tegra186 BPMP support on Tegra194

Timo Alho (3):
      firmware: tegra: Reword messaging terminology
      firmware: tegra: Refactor BPMP driver
      firmware: tegra: add bpmp driver for Tegra210

 drivers/firmware/tegra/Makefile        |   3 +
 drivers/firmware/tegra/bpmp-private.h  |  34 +++
 drivers/firmware/tegra/bpmp-tegra186.c | 305 ++++++++++++++++++++++++++
 drivers/firmware/tegra/bpmp-tegra210.c | 243 +++++++++++++++++++++
 drivers/firmware/tegra/bpmp.c          | 376 +++++++++++++--------------------
 include/soc/tegra/bpmp.h               |  13 +-
 6 files changed, 742 insertions(+), 232 deletions(-)
 create mode 100644 drivers/firmware/tegra/bpmp-private.h
 create mode 100644 drivers/firmware/tegra/bpmp-tegra186.c
 create mode 100644 drivers/firmware/tegra/bpmp-tegra210.c

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
