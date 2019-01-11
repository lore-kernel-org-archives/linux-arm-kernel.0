Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DAEC43613
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:07:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F4C2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NeEg0Eri";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XS3P+qFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F4C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZO22n6eRFjKBv015t1FgMoY6kfw6kgJGhnzUktDhG1Y=; b=NeEg0Eriabya+o
	11IdvciRzKGRIG6jgHDrNfg7UK2MSZMSsDu342D3+Vm0WXgwDDKVPG0BPnlBqF5KDklR5B4HsWaqE
	/WMiG6KUV/F9VFD2sm1hGvy/qKVTUpCLbDUi9IIAVZ3dnebeD1woE/gQBs2aoXTVVF3F2VEcBSdbt
	zIZF53bjmwGgGElejDyHQwPBfWkH/AH6G1J7MegZctA2sR0TsGhKkNmatAekUO5C8NVGVUkQL6yTh
	hEkzWPsDXq5B9Q1tSMFdQvTDr5EbTtozJPmwJi2JjcBLNmArQrybBav50rJiFbh++eJnQkHIQmpGA
	QABQPYDeYGQZYphDiOnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghyPL-0000lc-1u; Fri, 11 Jan 2019 15:07:39 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghyPH-0000jy-DT
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 15:07:36 +0000
Received: by mail-lf1-x143.google.com with SMTP id p6so11047701lfc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 07:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=QpS0qN3cPtVGcoS5jBxT/KIbjxs+ePVHQzVvs7kIRfc=;
 b=XS3P+qFrsDpby5u2cmyBNybPYVRGm/sxWN/vQjnANQ5qcwC4uBWNrOL/p8/r8uMHUK
 m1++WKxrMMnkq62ANYZy2iV8rilXdPqPSX7EnRAwtpz0UIoMfD6syT39p8U6eM23CHTb
 +dNFJ1Zcq9/R1QI35ImRwJuSzVpA+DOlshkoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=QpS0qN3cPtVGcoS5jBxT/KIbjxs+ePVHQzVvs7kIRfc=;
 b=oDdtn83LxukLbxsxvFH1EmjsdIrNGOyQnwjcj5FQyDbCL6EfBTwaBoIPRms8B0cpq4
 XLqjaTbTBrSu5gM7R1g98blF7kltlYoRW35Mq4UFg82ac8O1uiavHRbEJGVIXWnHWTGW
 0rwvy3+cD94yde4EJYprN8D7eu2UFCe4Z9+F0+e63c0p4zKn2NhLJO5+udCWb+zS2Ujk
 HHF4+FPKxpnN2lpgzkPrr6o/3EabYB6TBhydt6OOxtzBssoSRhPf+CARnUwNZgy6Z1GG
 tmKsCuz7gO4D9C9EZDAVrtn+ixZFSi6+HBNmsOq2Il8rdI2hWb5GQjBQrpxiBi+PZ5wv
 J5Vg==
X-Gm-Message-State: AJcUukfB/PCHvqG6YbX5rnMMVskioik9i5p0DcBlw+fSjMjqATMdPnjk
 yO85HnYrdINiIrGSPdKv/0qEMYD2Fp+ojk6KbR1UVA==
X-Google-Smtp-Source: ALg8bN7CI7rsfObqdbO/7zX07952101DGFQHK4UfjDL15DKAa9YA4YUR14f7r9vhHy7kJYELi1MLYIgFnPLx0NupOB4=
X-Received: by 2002:a19:5154:: with SMTP id f81mr8750859lfb.96.1547219252929; 
 Fri, 11 Jan 2019 07:07:32 -0800 (PST)
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 16:07:21 +0100
Message-ID: <CACRpkdb22-JT3GeJeqcOdXYJa9MyGMhujHxX-RgZOk7kbEkejw@mail.gmail.com>
Subject: [GIT PULL] Integrator fixes for v5.0+
To: arm-soc <arm@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_070735_481331_0E559490 
X-CRM114-Status: UNSURE (   9.93  )
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
Cc: Nicholas Mc Guire <hofrat@osadl.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SoC maintainers,

these are some overdue fixes for the Integrator.

It's your choice whether to queue for fixes or defer to v5.1, there are
not many users out there, at the same time it is nice if the code is
in shape.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-fixes-armsoc

for you to fetch changes up to 21face6f0d4d033d949d5517f307a15f76a9d9f2:

  ARM: integrator: impd1: use struct_size() in devm_kzalloc()
(2019-01-11 13:33:00 +0100)

----------------------------------------------------------------
Fixes for the Integrator:
- Handle failed allocations in the IM/PC bus attachment.
- Use struct_size() for allocation.

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      ARM: integrator: impd1: use struct_size() in devm_kzalloc()

Nicholas Mc Guire (1):
      gpio: pl061: handle failed allocations

 arch/arm/mach-integrator/impd1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
